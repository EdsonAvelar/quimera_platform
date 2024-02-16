FROM python:3.9-slim
COPY --from=openjdk:8-jre-slim /usr/local/openjdk-8 /usr/local/openjdk-8

ENV HADOOP_VERSION=3.3.6
ENV HIVE_METASTORE_VERSION=3.0.0
ENV POSTGRES_CONNECTOR_VERSION=42.2.18

# Set necessary environment variables.
ENV HADOOP_HOME="/opt/hadoop"
ENV PATH="/opt/spark/bin:/opt/hadoop/bin:${PATH}"
ENV DATABASE_DRIVER=org.postgresql.Driver
ENV DATABASE_TYPE=postgres
ENV DATABASE_TYPE_JDBC=postgresql
ENV DATABASE_PORT=5432
ENV JAVA_HOME=/usr/local/openjdk-8

#COPY binaries/hive-standalone-metastore-$HIVE_METASTORE_VERSION-bin.tar.gz /
#COPY postgresql-$POSTGRES_CONNECTOR_VERSION.jar /opt/postgresql-$POSTGRES_CONNECTOR_VERSION.jar
RUN apt-get update -y
RUN apt-get install -y curl net-tools --no-install-recommends

###############
##  HADOOP
###############
#RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
COPY binaries/hadoop-$HADOOP_VERSION.tar.gz /
RUN tar xf hadoop-$HADOOP_VERSION.tar.gz -C /opt
RUN ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop
RUN rm hadoop-$HADOOP_VERSION.tar.gz
RUN rm -r /opt/hadoop/share/doc
RUN ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop
RUN ln -s /opt/hadoop/share/hadoop/tools/lib/hadoop-aws* /opt/hadoop/share/hadoop/common/lib/
RUN ln -s /opt/hadoop/share/hadoop/tools/lib/aws-java-sdk* /opt/hadoop/share/hadoop/common/lib/


###############
##  METASTORE
###############
COPY binaries/hive-standalone-metastore-$HIVE_METASTORE_VERSION-bin.tar.gz /
RUN tar xf hive-standalone-metastore-$HIVE_METASTORE_VERSION-bin.tar.gz  -C /opt/
RUN ln -s /opt/apache-hive-metastore-$HIVE_METASTORE_VERSION-bin /opt/hive-metastore
RUN rm hive-standalone-metastore-$HIVE_METASTORE_VERSION-bin.tar.gz
RUN rm /opt/apache-hive-metastore-$HIVE_METASTORE_VERSION-bin/lib/guava-19.0.jar
RUN cp /opt/hadoop-$HADOOP_VERSION/share/hadoop/hdfs/lib/guava-27.0-jre.jar /opt/apache-hive-metastore-$HIVE_METASTORE_VERSION-bin/lib/

###############
##  POSTGRESS CONNECTION
###############
COPY binaries/postgresql-$POSTGRES_CONNECTOR_VERSION.jar /opt/
RUN ln -s /opt/postgresql-$POSTGRES_CONNECTOR_VERSION.jar /opt/hadoop/share/hadoop/common/lib/
RUN ln -s /opt/postgresql-$POSTGRES_CONNECTOR_VERSION.jar /opt/hive-metastore/lib/

###############
##  CLEAN
###############
RUN apt-get purge -y --auto-remove && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY run.sh run.sh

COPY configs/hive-site.xml /opt/hadoop/etc/hadoop/hive-site.xml
COPY configs/metastore-site.xml /opt/hive-metastore/conf/metastore-site.xml
COPY configs/core-site.xml /opt/hadoop/etc/hadoop/core-site.xml

CMD [ "./run.sh" ]
HEALTHCHECK CMD [ "sh", "-c", "netstat -ln | grep 9083" ]

