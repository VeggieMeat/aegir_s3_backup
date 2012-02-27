#!/bin/bash
#
# Fabfile wrapper script
#

# Fabfile location
FABFILE=/usr/local/bin/aegir_s3_backup/fabfile.py

HOST=$1
BUCKET=$2
PGP=$3
PASSPHRASE=$4
AWS_ACCESS=$5
AWS_SECRET=$6

if [ -z $HOST ]; then
  echo "Please specify a host. Exiting"
  exit 1
fi

if [ -z $BUCKET ]; then
  echo "S3 bucket must be specified. Exiting"
  exit 1
fi

if [ -z $PGP ]; then
  echo "PGP key ID must be specified. Exiting"
  exit 1
fi

if [ -z $PASSPHRASE ]; then
  echo "PGP passphrase required. Exiting"
  exit 1
fi

if [ -z $AWS_ACCESS ]; then
  echo "AWS Access Key ID required. Exiting"
  exit 1
fi

if [ -z $AWS_SECRET ]; then
  echo "AWS Secret Key required. Exiting"
  exit 1
fi

fab -f $FABFILE -H $HOST backup:bucket=$BUCKET,pgp=$PGP,passphrase=$PASSPHRASE,aws_access=$AWS_ACCESS,aws_secret=$AWS_SECRET || exit 1
