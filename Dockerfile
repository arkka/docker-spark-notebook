# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/pyspark-notebook:d7b570a16da5

MAINTAINER Arkka Dhiratara <arkka.d@gmail.com>

USER root

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

# Python Package
RUN pip2 --no-cache-dir install pytz sklearn numpy elasticsearch unidecode nltk Sastrawi
