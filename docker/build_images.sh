#!/bin/bash

# Version of ContinuumIO's Anaconda3 docker image to use as the base image
ANACONDA3_VERSION=5.3.0

# Version of pre-built  Apache spark and Hadoop from spark.apache.org
APACHE_SPARK_VERSION=2.4.5
HADOOP_VERSION=2.7
PREBUILT_URL_BASE=https://downloads.apache.org/spark
# check https://www.apache.org/dyn/closer.lua/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz for suggested mirrors

# Version of py4j used in the Spark build
PY4J_VERSION=0.10.7

docker build --build-arg APACHE_SPARK_VERSION=$APACHE_SPARK_VERSION \
    --build-arg HADOOP_VERSION=$HADOOP_VERSION \
    --build-arg PY4J_VERSION=$PY4J_VERSION \
    --build-arg ANACONDA3_VERSION=$ANACONDA3_VERSION \
    --build-arg PREBUILT_URL_BASE=$PREBUILT_URL_BASE \
    -t spark-base:$APACHE_SPARK_VERSION base

docker build \
    --build-arg APACHE_SPARK_VERSION=$APACHE_SPARK_VERSION \
    -t spark-master:$APACHE_SPARK_VERSION master

docker build \
    --build-arg APACHE_SPARK_VERSION=$APACHE_SPARK_VERSION \
    -t spark-worker:$APACHE_SPARK_VERSION worker

docker build \
    --build-arg APACHE_SPARK_VERSION=$APACHE_SPARK_VERSION \
    -t spark-pyspnb:$APACHE_SPARK_VERSION pyspnb
