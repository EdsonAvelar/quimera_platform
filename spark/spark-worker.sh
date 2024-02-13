#!/bin/bash

/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://spark-master:7078 --webui-port 8081