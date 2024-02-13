FROM python:3.9-slim
COPY --from=openjdk:8-jre-slim /usr/local/openjdk-8 /usr/local/openjdk-8

# Install OpenJDK 8
RUN mkdir -p /usr/share/man/man1mkdir -p /usr/share/man/man1 && \
    rm -rf /var/lib/apt/lists/*
RUN python3 -m pip install --upgrade pip
ENV JAVA_HOME /usr/local/openjdk-8
RUN update-alternatives --install /usr/bin/java java /usr/local/openjdk-8/bin/java 1
#ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin
RUN echo $JAVA_HOME

RUN apt-get update -y && apt-get install -y libzbar-dev bash gcc git libc-dev curl wget vim nano \
    && apt-get install -y iputils-ping telnet openssh-client net-tools \
    man unzip vim-tiny bc openssh-server thrift-compiler sudo \
    && apt-get install -y build-essential 

# # install spark
RUN curl -o spark-3.1.1-bin-hadoop3.2.tgz https://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-hadoop3.2.tgz && \
    tar -xzvf spark-3.1.1-bin-hadoop3.2.tgz && \
    mv spark-3.1.1-bin-hadoop3.2 /opt/spark && \
    rm -rf spark-3.1.1-bin-hadoop3.2.tgz

ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV PATH=$PATH:$SPARK_HOME/sbin
RUN echo $SPARK_HOME/python3/lib/

ENV PYTHONPATH=$SPARK_HOME/python3:$SPARK_HOME/python/lib/py4j-0.10.9-src.zip:$PYTHONPATH

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


COPY ./dags ./opt/airflow/dags
RUN chmod -R a+rwx /opt/airflow
COPY airflow.cfg /opt/airflow/airflow.cfg
COPY run.sh ./run.sh
RUN chmod +x /run.sh
WORKDIR /opt/airflow

CMD /run.sh
EXPOSE 8000