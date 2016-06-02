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

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


# configuration screen to connect to urbandev postgres database
# 'postgresql://<user>:<password>@<host>:<port>/<database>'
PG_CONFIG = 'postgresql://jeff:password@localhost:5432/urbandev'
# path to json output directory
OUTPUT = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'output')


def initialize_session(config):
    """ connect to postgres database and return session used for queries """
    engine = create_engine(config)
    session = sessionmaker(bind=engine)
    return session()


def dump_pretty_json(json_object):
    """ dump pretty-json """
    return json.dumps(json_object, sort_keys=True, indent=2, separators=(',', ': '))


def generate_json(session, output_directory):
    """ generate json for each Zillow neighborhood """
    for record in session.execute("SELECT * FROM zillow_json"):
        filename = "{regionid}.json".format(regionid=record['regionid'])
        with open(os.path.join(output_directory, filename), 'w') as jsonfile:
            jsondata = dump_pretty_json(record['json'])
            jsonfile.write(jsondata)


def main():
    """ main function to generate static json for each Zillow neighborhood """
    session = initialize_session(PG_CONFIG)
    generate_json(session, OUTPUT)


if __name__ == '__main__':
    main()
