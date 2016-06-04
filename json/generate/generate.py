"""
Connect to postgres database and generate json files for each zillow neighborhood

You must modify `PGCONFIG` for your environment

Usage:
    # install python dependencies
    # (requires python-dev and postgresql-server-dev-X.X system packages)
    pip install -r requirements.txt

    # run
    python generate.py

This will generate an json file for each Zillow neighborhood
available inside the `OUTPUT` directory
"""


import json
import os
import sys

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.exc import OperationalError

from s3 import S3Bucket, build_key # pylint: disable=relative-import
try:
    from zillow import process_zillow_data
except ImportError:
    # add directory with zillow module to our path
    SCRIPTDIR = os.path.dirname(os.path.realpath(__file__))
    PARENT = os.path.dirname(SCRIPTDIR)
    sys.path.insert(0, os.path.join(PARENT, 'zillow'))
    from zillow import process_zillow_data # pylint: disable=no-name-in-module


# configuration screen to connect to urbandev postgres database
# 'postgresql://<user>:<password>@<host>:<port>/<database>'
# leave user, password, host and port empty to connect using peer authentication
PGCONFIG_ENVVAR = 'URBANDEV_PGCONFIG'
PGCONFIG = os.getenv(PGCONFIG_ENVVAR, 'postgresql://@/urbandev')
# path to json output directory
OUTPUT = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'output')


def initialize_session(config):
    """ connect to postgres database and return session used for queries """
    engine = create_engine(config)
    try:
        # make sure we can connect to database using config string
        connection = engine.connect()
        connection.close()
    except OperationalError as error:
        # connection failed so print error message and exit
        msg = "{0}\nFailed to open connection to database.\n"
        msg += "Try setting `{1}` environment variable, or\n"
        msg += "modifying `PGCONFIG` variable with valid connection string"
        print msg.format(error, PGCONFIG_ENVVAR)
        sys.exit(1)
    session = sessionmaker(bind=engine)
    return session()


def dump_pretty_json(json_object):
    """ dump pretty-json """
    return json.dumps(json_object, sort_keys=True, indent=2, separators=(',', ': '))


def generate_json(session, zillow_data, output_directory):
    """ generate json for each Zillow neighborhood """
    bucket = S3Bucket()
    # clear S3 Bucket
    bucket.clear()
    for record in session.execute("SELECT * FROM zillow_json"):
        regionid = str(record['regionid'])
        filename = "{regionid}.json".format(regionid=regionid)
        output = os.path.join(output_directory, filename)
        with open(output, 'w') as jsonfile:
            data = dict(record['json'])
            if regionid not in zillow_data:
                # missing zillow data for this regionid??
                print "WARN: No zillow data for", record['name'], regionid
                data['Zillow'] = None
            else:
                data['Zillow'] = zillow_data[regionid]['Zillow']
            jsondata = dump_pretty_json(data)
            jsonfile.write(jsondata)
            key = build_key(filename)
        # store json in S3 object
        bucket.store(key, output)
    print "Output json files in: {0}".format(output_directory)


def generate_zillow_data():
    """ process zillow data using imported function from zillow.py """
    zillow_data = dict()
    def handler(data, regionid):
        """ add data for each region to our zillow_data dictionary """
        zillow_data[regionid] = data
    process_zillow_data(region_handler=handler)
    return zillow_data


def main():
    """ main function to generate static json for each Zillow neighborhood """
    session = initialize_session(PGCONFIG)
    zillow_data = generate_zillow_data()
    generate_json(session, zillow_data, OUTPUT)


if __name__ == '__main__':
    main()
