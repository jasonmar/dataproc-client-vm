# Dataproc Client VM Instance

This repository provides a startup script and instructions for creating a Dataproc client VM which has client software installed and configured to submit jobs to a remote Dataproc cluster.

## Instructions

1. Find the name of the dataproc cluster you want to create a client for.
2. Upload [startup.sh](startup.sh) to a GCS bucket accessible by your service account.
3. Provision a Dataproc cluster using the launch script below, replacing `my-project` `my-dataproc-client` `my-service-account` and `my-bucket` with your own values. You may also need to modify the startup script if your environment has other required scripts that need to be executed.
4. The client dataproc cluster will show an error `Cannot start master: NameNode is not running` which can be ignored.

## Launch script

```sh
gcloud beta dataproc clusters create my-dataproc-client \
  --region us-east1 --subnet data --no-address --zone us-east1-b \
  --single-node --master-machine-type n1-standard-2 \
  --master-boot-disk-size 200 --image-version preview \
  --tags internal --project my-project \
  --service-account my-service-account@my-project.iam.gserviceaccount.com \
  --metadata=target-dataproc-cluster=my-dataproc-cluster,startup-script-url=gs://my-bucket/startup.sh
```


## How this works

Dataproc uses `/usr/local/share/google/dataproc/startup-script*.sh` to install services like Hadoop NameNode, YARN Resource Manager and Hive Metastore.

The included startup script replaces the `MASTER_HOSTNAMES` variable to use the master hostname of the target dataproc cluster. When the script writes configuration files, all client software references the master of the target dataproc cluster. When starting `hive` or `spark-shell` the session will be created on the remote cluster instead of locally.
