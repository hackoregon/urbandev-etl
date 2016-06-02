import json
import re
import os
import pandas as pd

OUTPUT_DIR = 'output'
DATA_DIR = os.getcwd() + '/raw_data'
ZILLOW_CSV_FILES = {
    'med_list': 'Neighborhood_MedianListingPrice_AllHomes.csv',
    'med_list_sqft': 'Neighborhood_MedianListingPricePerSqft_AllHomes.csv',
    'med_rentalprice': 'Neighborhood_MedianRentalPrice_AllHomes.csv',
    'med_rentalprice_sqft' : 'Neighborhood_MedianRentalPricePerSqft_AllHomes.csv',
    'zri_all': 'Neighborhood_Zri_AllHomes.csv',
    'zri_all_sqft': 'Neighborhood_ZriPerSqft_AllHomes.csv',
    'med_sold': 'Neighborhood_MedianSoldPrice_AllHomes.csv',
    'med_sold_sqft': 'Neighborhood_MedianSoldPricePerSqft_AllHomes.csv',
    'zhvi_all': 'Neighborhood_Zhvi_AllHomes.csv',
    'med_val_sqft': 'Neighborhood_MedianValuePerSqft_AllHomes.csv'
}

## Zillow data explore and cleanup
def filter_portland(dict_df):
    pdx_dict_df = dict()
    for k, v in dict_df.items():
        pdx_dict_df[k] = get_portland(v)
    return pdx_dict_df

def get_num_rows(dict_df):
    for k, v in dict_df.items():
        print(k)
        print(len(v.index))

def dict_df_columns_cleanup(dict_df):
    cleaned_dict_df = dict()
    for k, v in dict_df.items():
        cleaned_dict_df[k] = df_columns_cleanup(v)
    return cleaned_dict_df

def df_columns_cleanup(df):
    # Replace NaN with None, so json write produces null rather than NaN
    df = df.where((pd.notnull(df)), None)
    # Alias Zillow neighborhood to 'Neighborhood'
    if 'RegionName' in df.columns:
        df['Neighborhood'] = df['RegionName']
    return df

def get_OR_WA(df):
    return df.loc[(df['State'] == 'WA') | (df['State'] == 'OR')]

def get_portland(df):
    return df.loc[(df['Metro'] == 'Portland') & (df['State'] == 'OR')]

def get_months_list(df):
    # Compile all year-month column headers with regex match
    months_list = []
    all_cols = list(df.columns.values)
    for col_name in all_cols:
        if re.match("\d{4}-\d{2}", col_name):
            months_list.append(col_name)
    return months_list

def region_in_df(df, regionid):
    # Check if a Zillow Region is in a given dataframe
    result = df.loc[df['RegionID'] == regionid]
    if result.empty:
        return False
    return True

def get_region_vals(df, regionid):
    # Return a dictionary of all months and values in a dataframe
    row = df.loc[df['RegionID'] == regionid]
    value_dict = dict()
    months = get_months_list(df)
    values = []
    for month in months:
        values.append(row[month].item())
    value_dict['Months'] = months
    value_dict['Values'] = values
    return value_dict

def get_regionid_list(df):
    # Return a list of all Zillow RegionID values in a dataframe
    return df['RegionID'].tolist()

def get_regionname(df, regionid):
    # Get the Zillow RegionName (Portland neighborhood) by Zillow RegionID
    return df.loc[df['RegionID'] == regionid, 'RegionName'].item()

def create_region_dict(df, regionid, z_variable='zillow_json'):
    zillow_dict = dict()
    zillow_dict[z_variable] = get_region_vals(df, regionid)
    return get_region_vals(df, regionid)


## Read CSV, write JSON
def load_csv(csv_name):
    return pd.read_csv(os.path.join(DATA_DIR, csv_name))

def load_raw_data(csv_dict):
    dict_df = dict()
    for k, v in csv_dict.items():
        dict_df[k] = load_csv(v)
    return dict_df

def write_json(dict_to_write, filename):
    # JSON is written to a formatted_data directory on same filepath as script.
    with open(os.path.join(OUTPUT_DIR, filename + '.json'), 'w') as fp:
        json.dump(dict_to_write, fp)

def process_region(dfs, regionid, handler):
    # generate json object for each region and pass to handler
    z_dict = dict()
    name = 'Unknown'
    for k, v in dfs.items():
        if region_in_df(v, regionid):
            z_dict[k] = create_region_dict(v, regionid, k)
            name = get_regionname(v, regionid)
    region_dict = dict()
    region_dict['RegionName'] = name
    region_dict['RegionID'] = int(regionid)
    region_dict['Zillow'] = z_dict
    # the handler function is provided as a keyword argument
    # `write_json` is the default handler, it will write
    # a json file for the region to `OUTPUT_DIR`
    handler(region_dict, str(regionid))
    return region_dict

def process_zillow_data(csvfiles=ZILLOW_CSV_FILES, region_handler=write_json):
    dict_df_all = load_raw_data(csvfiles)
    dict_df_pdx = filter_portland(dict_df_all)
    dict_df_pdx = dict_df_columns_cleanup(dict_df_pdx)

    # Dataframe dictionary - keys are desired json key names, values are dataframes
    dfs = dict({'MedianValue_sqft': dict_df_pdx['med_val_sqft'],
                'MedianSold_sqft': dict_df_pdx['med_sold_sqft'],
                'ZRI_sqft': dict_df_pdx['zri_all_sqft']})

    # Using the list of Zillow RegionIDs from median value per sqft data, as
    # this dataset has the highest number of regions (115) returned for Portland
    # Metro. Could instead compile set of all unique RegionID values from each
    # desired variable to create a master list.
    medval_regionids = get_regionid_list(dict_df_pdx['med_val_sqft'])
    for region in medval_regionids:
        process_region(dfs, region, region_handler)

if __name__ == "__main__":
    process_zillow_data()
