"""
S3Bucket wrapper class that handlers interaction with AWS Bucket using boto3

+ Required environment variables for AWS
    * AWS_DEFAULT_REGION    (us-west-2) for plot-pdx bucket
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
+ Optional environment variables
    * URBANDEV_S3_BUCKET
    * URBANDEV_S3_PREFIX

"""

import logging
import os

import boto3
import botocore


logging.basicConfig(level=logging.INFO)
BUCKET = os.getenv('URBANDEV_S3_BUCKET', 'plot-pdx')
PREFIX = os.getenv('URBANDEV_S3_PREFIX', 'data/v1')


def check_envvar(envvar):
    """ raise exception if environment variable is not set """
    if not os.environ.get(envvar):
        raise EnvironmentError("Variable '%s' not set" % envvar)


def build_key(key):
    """ append key to bucket prefix """
    return os.path.join(PREFIX, key)


class S3Bucket(object):
    """ Wrapper for interacting with AWS S3 buckets """

    ENVVARS = ['AWS_DEFAULT_REGION', 'AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY']

    def __init__(self, bucketname=BUCKET):
        self.bucketname = bucketname
        # will raise exception if credentials are not set
        self.resource = boto3.resource('s3')

    def _bucket_exists(self):
        """ check if a bucket exists on S3 (should not throw error) """
        try:
            self.resource.meta.client.head_bucket(Bucket=self.bucketname)
        except botocore.exceptions.ClientError as error:
            # If a client error is thrown, then check that it was a 404 error.
            # If it was a 404 error, then the bucket does not exist.
            error_code = int(error.response['Error']['Code'])
            if error_code == 404:
                raise LookupError("Bucket '%s' does not exist", self.bucketname)
            else:
                # maybe a permissions issue
                raise error
        return True

    def store(self, key, filepath):
        """ store object in bucket """
        if not key or not filepath:
            return False
        # check that file actually exists and handle errors
        if not os.path.isfile(filepath):
            logging.error("File '%s' does not exists, skipping", filepath)
            return False
        else:
            obj = self.resource.Object(self.bucketname, key)
            obj.put(Body=open(filepath, 'rb'))
            obj.Acl().put(ACL='public-read')
            return True

    def get(self, key):
        """ get object from bucket """
        try:
            return self.resource.Object(self.bucketname, key).get()
        except botocore.exceptions.ClientError as error:
            if error.response['Error']['Code'] == 'NoSuchKey':
                # key does not exists
                raise KeyError(error.response['Error'])
            else:
                # unexpected error
                raise error

    def delete(self, key):
        """ delete object in bucket """
        self.resource.Object(self.bucketname, key).delete()

    def get_keys(self):
        """ list contents of bucket """
        bucket = self.resource.Bucket(self.bucketname)
        return [key.key for key in bucket.objects.all()]

    def clear(self, prefix=PREFIX):
        """ clear bucket with matching prefix """
        for key in self.get_keys():
            # delete files in folder by not actual folder
            if key.startswith(prefix) and prefix + "/" != key:
                self.delete(key)

def main():
    """ main function """
    bucket = S3Bucket(BUCKET)
    logging.info(bucket.get_keys())
    #bucket.clear()


if __name__ == '__main__':
    main()
