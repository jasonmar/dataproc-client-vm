#!/bin/bash

gcloud beta dataproc clusters create my-dataproc-client --region us-east1 --subnet data --no-address --zone us-east1-b --single-node --master-machine-type n1-standard-2 --master-boot-disk-size 200 --image-version preview --tags internal --project my-project --service-account my-service-account@my-project.iam.gserviceaccount.com --metadata=target-dataproc-cluster=my-dataproc-cluster,startup-script-url=gs://my-bucket/startup.sh
