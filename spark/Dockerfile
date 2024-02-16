FROM python:3.9-slim
COPY --from=openjdk:8-jre-slim /usr/local/openjdk-8 /usr/local/openjdk-8

ENV SPARK_VERSION 3.5.0

# Install OpenJDK 8
RUN mkdir -p /usr/share/man/man1mkdir -p /usr/share/man/man1 && \
    rm -rf /var/lib/apt/lists/*
RUN python3 -m pip install --upgrade pip
ENV JAVA_HOME=/usr/local/openjdk-8
RUN update-alternatives --install /usr/bin/java java /usr/local/openjdk-8/bin/java 1
ENV PATH=$PATH:$JAVA_HOME/bin


RUN apt-get update -y && apt-get install -y libzbar-dev bash gcc git libc-dev curl wget vim nano \
    && apt-get install -y iputils-ping telnet openssh-client net-tools \
    man unzip vim-tiny bc openssh-server thrift-compiler sudo \
    && apt-get install -y build-essential 

# # install spark
COPY binaries/spark-$SPARK_VERSION-bin-hadoop3.tgz /

RUN tar -xzvf spark-$SPARK_VERSION-bin-hadoop3.tgz && \
    mv spark-$SPARK_VERSION-bin-hadoop3 /opt/spark && \
    rm -rf spark-$SPARK_VERSION-bin-hadoop3.tgz 


ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV PATH=$PATH:$SPARK_HOME/sbin
ENV PYTHONPATH=$SPARK_HOME/python3:$SPARK_HOME/python/lib/py4j-0.10.9.7-src.zip:$PYTHONPATH


ENV PYSPARK_DRIVER_PYTHON=/usr/bin/python3
ENV PYSPARK_PYTHON=/usr/bin/python3
ENV PYSPARK_DRIVER_PYTHON=/usr/bin/python3


RUN  ln -sf /usr/bin/python3.11 /usr/local/bin/python

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copiando binários para pasta jar do spark
COPY binaries/hadoop-aws-3.3.4.jar $SPARK_HOME/jars/
COPY binaries/postgresql-42.2.18.jar $SPARK_HOME/jars/
COPY binaries/aws-java-sdk-bundle-1.12.262.jar $SPARK_HOME/jars/

RUN mkdir -p /opt/spark/history
COPY spark-defaults.conf /opt/spark/conf/spark-defaults.conf

COPY configs/hive-site.xml $SPARK_HOME/conf/

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
ADD spark-master.sh spark-worker.sh /