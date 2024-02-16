#!/bin/bash

echo "History server is sarting ...."

#export SPARK_VERSION=3.4.2

start-history-server.sh
#start-connect-server.sh --packages org.apache.spark:spark-connect_2.12:$SPARK_VERSION

echo "$(hostname -i) spark-master" >> /etc/hosts

/opt/spark/bin/spark-class org.apache.spark.deploy.master.Master --ip 0.0.0.0 --port 7078 --webui-port 8080
