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
import logging

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.exc import OperationalError

from s3 import upload as s3upload # pylint: disable=relative-import
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
        msg = "%s\nFailed to open connection to database.\n"
        msg += "Try setting `%s` environment variable, or\n"
        msg += "modifying `PGCONFIG` variable with valid connection string"
        logging.error(msg, error, PGCONFIG_ENVVAR)
        sys.exit(1)
    session = sessionmaker(bind=engine)
    return session()


def dump_json(json_object, pretty=True):
    """ dump pretty-json """
    if not pretty:
        return json.dumps(json_object)
    return json.dumps(json_object, sort_keys=True, indent=2, separators=(',', ': '))


def generate_json(session, output_directory, pretty=True):
    """ generate json for each Zillow neighborhood """
    json_files = []
    for record in session.execute("SELECT * FROM zillow_json"):
        regionid = str(record['regionid'])
        filename = "{regionid}.json".format(regionid=regionid)
        output = os.path.join(output_directory, filename)
        with open(output, 'w') as jsonfile:
            data = dict(record['json'])
            jsondata = dump_json(data, pretty=pretty)
            jsonfile.write(jsondata)
            json_files.append(output)
    return json_files


def generate(pretty=True):
    """ generate static json for each Zillow neighborhood """
    session = initialize_session(PGCONFIG)
    # returns list of filepaths for each region json
    return generate_json(session, OUTPUT, pretty=pretty)


def main():
    """ main function, generate json for each neighborhod and upload to s3 """
    # generate json file for each neighborhood
    s3upload(generate(pretty=False))
    # only generate json for testing
    #generate(pretty=True)


if __name__ == '__main__':
    main()

