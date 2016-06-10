"""
Testing s3.py module

+ Check that required environment variables for AWS have been set
    * AWS_DEFAULT_REGION    (us-west-2) for plot-pdx bucket
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
+ Check that we can store, retrieve and delete objects from S3 bucket
+ The tests will try and use environment variables for bucket name and prefix
    * URBANDEV_S3_BUCKET    (default='plot-pdx')
    * URBANDEV_S3_PREFIX    (default='data/v1')
"""


import json
import os
import sys
import unittest
import uuid

try:
    import s3
except ImportError:
    PARENT = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
    sys.path.insert(0, PARENT)
    import s3 # pylint: disable=import-error


def setUpModule(): # pylint: disable=invalid-name
    """
    check that required environment variables are set
    will cause early termination by raising EnvironmentError
    """
    for envvar in s3.S3Bucket.ENVVARS:
        s3.check_envvar(envvar)


class TestBucketExists(unittest.TestCase):
    """ check aws S3 bucket exists """

    def test_valid_bucket(self):
        """ check that valid bucket name exists """
        bucket = s3.S3Bucket(s3.BUCKET)
        exists = bucket._bucket_exists() # pylint: disable=protected-access
        self.assertTrue(exists)

    def test_invalid_bucket(self):
        """ check that random bucket name throws LookupError """
        random_bucket = str(uuid.uuid4())
        bucket = s3.S3Bucket(random_bucket)
        exists = bucket._bucket_exists # pylint: disable=protected-access
        self.assertRaises(LookupError, exists)


class TestPrefixExists(unittest.TestCase):
    """ check that bucket prefix exists """

    def test_validate_prefix(self):
        """ validate that bucket PREFIX actually exists """
        bucket = s3.S3Bucket(s3.BUCKET)
        match = False
        for key in bucket.get_keys():
            if key.startswith(s3.PREFIX):
                match = True
                break
        error = "No key found with matching prefix '%s'" % s3.PREFIX
        self.assertTrue(match, error)


class TestBasicBucketOperations(unittest.TestCase):
    """ test some basic bucket operations """

    def setUp(self):
        """ create bucket """
        self.bucket = s3.S3Bucket(s3.BUCKET)
        self.key = 'test-%s' % uuid.uuid4()
        self.filepath = None
        self.data = dict(foo='bar')

    def tearDown(self):
        """ remove temp file and remove test object from bucket """
        if self.filepath and os.path.isfile(self.filepath):
            os.remove(self.filepath)
        self.bucket.delete(self.key)

    def test_empty_parameters(self):
        """ test trying to store empty keys or files """
        error = "Expected False return value"
        self.assertFalse(self.bucket.store(None, None), error)
        self.assertFalse(self.bucket.store('', None), error)
        self.assertFalse(self.bucket.store('', ''), error)
        self.assertFalse(self.bucket.store(None, ''), error)

    def test_invalid_file(self):
        """ test path to non-existant file """
        error = "Expected False return value"
        filepath = os.path.join('/tmp', str(uuid.uuid4()))
        self.assertFalse(self.bucket.store('foobar', filepath), error)

    def test_missing_key_get(self):
        """ test that KeyError is raised for non-existant key """
        with self.assertRaises(KeyError):
            self.bucket.get(self.key)

    def test_delete_nonexistant_object(self):
        """ check that existing object gets deleted """
        # should handle gracefully
        self.bucket.delete(self.key)

    def test_valid_store_get_delete(self):
        """ test entire chain of storing, retrieving and deleting an object """
        error = "Expected True return value when storing object"
        # store object with test data
        self.filepath = os.path.join('/tmp', str(uuid.uuid4()))
        json.dump(self.data, open(self.filepath, 'wb'))
        self.assertTrue(self.bucket.store(self.key, self.filepath), error)
        # retrieve object and check contents
        data = json.loads(self.bucket.get(self.key)['Body'].read())
        error = "Expected data %s actual data retrieved %s" % (self.data, data)
        self.assertEqual(self.data, data, error)
        # delete object and check that we cannot retrieve it
        self.bucket.delete(self.key)
        with self.assertRaises(KeyError):
            self.bucket.get(self.key)


if __name__ == '__main__':
    unittest.main()
