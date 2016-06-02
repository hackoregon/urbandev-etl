"""
Connect to postgres database and generate json files for each zillow neighborhood

You must modify `PG_CONFIG` for your environment

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


def generate_json(session, output_directory):
    """ generate json for each Zillow neighborhood """
    for record in session.execute("SELECT * FROM zillow_json"):
        filename = "{regionid}.json".format(regionid=record['regionid'])
        output = os.path.join(output_directory, filename)
        print "{0}: {1}".format(record['name'], output)
        with open(output, 'w') as jsonfile:
            jsondata = dump_pretty_json(record['json'])
            jsonfile.write(jsondata)


def main():
    """ main function to generate static json for each Zillow neighborhood """
    session = initialize_session(PGCONFIG)
    generate_json(session, OUTPUT)


if __name__ == '__main__':
    main()
