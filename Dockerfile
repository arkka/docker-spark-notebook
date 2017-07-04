# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/pyspark-notebook

MAINTAINER Arkka Dhiratara <arkka.d@gmail.com>

USER root

# RSpark config
ENV R_LIBS_USER $SPARK_HOME/R/lib

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# SPARK ADDITIONAL JARS FOR AWS
RUN curl -sL -O --retry 3 \
    "http://search.maven.org/remotecontent?filepath=com/amazonaws/aws-java-sdk/1.11.119/aws-java-sdk-1.11.119.jar" \
    | > $SPARK_HOME/jars/aws-java-sdk-1.11.119.jar \
    && curl -sL -O --retry 3 \
    "http://search.maven.org/remotecontent?filepath=org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar" \
    | > $SPARK_HOME/jars/hadoop-aws-2.7.3.jar \
    && curl -sL -O --retry 3 \
    "http://search.maven.org/remotecontent?filepath=org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar" \
    | > $SPARK_HOME/jars/hadoop-aws-2.7.3.jar

USER $NB_USER

# R packages
RUN conda config --add channels r && \
    conda install --quiet --yes \
    'r-base=3.3.2' \
    'r-irkernel=0.7*' \
    'r-ggplot2=2.2*' \
    'r-rcurl=1.95*' && conda clean -tipsy

# Apache Toree kernel
RUN pip --no-cache-dir install https://dist.apache.org/repos/dist/dev/incubator/toree/0.2.0/snapshots/dev1/toree-pip/toree-0.2.0.dev1.tar.gz && jupyter toree install --sys-prefix

# Spylon-kernel
RUN conda install --quiet --yes 'spylon-kernel=0.2*' && python -m spylon_kernel install --sys-prefix

# Python Package
RUN pip2 --no-cache-dir install pytz sklearn numpy elasticsearch unidecode nltk Sastrawi
