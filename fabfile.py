from fabric.api import *
import time

env.user = 'aegir'
env.shell = '/bin/bash -c'

def backup(bucket, pgp, passphrase, aws_access, aws_secret):
  print "===> Backing up Aegir sites locally"
  run("sh backup.sh")
  with prefix("export PASSPHRASE=%s; export AWS_ACCESS_KEY_ID=%s; export AWS_SECRET_ACCESS_KEY=%s" %(passphrase, aws_access, aws_secret)):
    print "===> Removing backups older than one month from S3"
    run("duplicity remove-older-than 1M --encrypt-key=%s --sign-key=%s s3+http://%s" %(pgp, pgp, bucket))
    print "===> Backup up Aegir backup to S3"
    run("duplicity --full-if-older-than 14D --encrypt-key=%s --sign-key=%s /var/aegir/backups s3+http://%s" %(pgp, pgp, bucket))
    run("export PASSPHRASE=")
    run("export AWS_ACCESS_KEY_ID=")
    run("export AWS_SECRET_ACCESS_KEY=")

