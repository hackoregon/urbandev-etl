Generate JSON for each Zillow Neighborhood
==========================================


+ Connects to `urbandev` postgres database created with `build_db` script
+ You must modify `PGCONFIG` for your environment
+ Will load json files into S3 bucket
+ Requires some environment variables to be set
    * `AWS_DEFAULT_REGION` (us-west-2) for plot-pdx bucket
    * `AWS_ACCESS_KEY_ID`
    * `AWS_SECRET_ACCESS_KEY`


#### Python Dependencies
```
pip install -r requirements.txt
```

#### S3 Tests
```
python tests/s3_tests.py
```

#### Usage
```
python generate.py
```

This will generate an json file for each Zillow neighborhood
available inside the output directory, and upload it to an Amazon S3 Bucket
