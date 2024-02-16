FROM python:3.9-slim
COPY --from=openjdk:8-jre-slim /usr/local/openjdk-8 /usr/local/openjdk-8

ENV SPARK_VERSION 3.5.0

# Install OpenJDK 8

RUN python3 -m pip install --upgrade pip
RUN apt-get update -y && apt-get install -y procps

ENV JAVA_HOME=/usr/local/openjdk-8
RUN update-alternatives --install /usr/bin/java java /usr/local/openjdk-8/bin/java 1

RUN mkdir /notebooks

ENV PATH=$PATH:$JAVA_HOME/bin

RUN pip install jupyterlab notebook
RUN pip install pyspark==3.5.0 pandas
RUN pip install s3fs minio

# # # install spark
# COPY spark-$SPARK_VERSION-bin-hadoop3.tgz /
# RUN tar -xzvf spark-$SPARK_VERSION-bin-hadoop3.tgz && \
#     mv spark-$SPARK_VERSION-bin-hadoop3 /opt/spark && \
#     rm -rf spark-$SPARK_VERSION-bin-hadoop3.tgz 



# ENV PATH=$PATH:$SPARK_HOME/bin
# ENV PATH=$PATH:$SPARK_HOME/sbin
# ENV PYTHONPATH=$SPARK_HOME/python3:$SPARK_HOME/python/lib/py4j-0.10.9.7-src.zip:$PYTHONPATH


# ENV PYSPARK_DRIVER_PYTHON=/usr/bin/python3
# ENV PYSPARK_PYTHON=/usr/bin/python3
# ENV PYSPARK_DRIVER_PYTHON=/usr/bin/python3

# COPY configs/hive-site.xml $SPARK_HOME/conf/
# RUN  ln -sf /usr/bin/python3.11 /usr/local/bin/python

# COPY requirements.txt requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt