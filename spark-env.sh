#!/usr/bin/env bash 
export SPARK_MASTER_IP='$1'
export SPARK_LOCAL_DIRS='/home/$USER/sparkDataSet/' 
export SPARK_WORKER_CORES=1
export SPARK_WORKER_MEMORY=1024
export SPARK_WORKER_INSTANCES=1
