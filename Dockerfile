ARG TARGET="cloud"

FROM bitnami/spark:3.5-debian-12 AS dev
# FROM us-central1-docker.pkg.dev/cloud-dataproc/spark/dataproc_2.0:3.1-dataproc-19

###############################################################
FROM python:3.9.21-bookworm AS cloud

# Suppress interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

USER root
# Install utilities required by Spark scripts.
RUN apt update && apt install -y procps tini libjemalloc2
USER $NB_UID

# Enable jemalloc2 as default memory allocator
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

# Create the 'spark' group/user.
# The GID and UID must be 1099. Home directory is required.
RUN groupadd -g 1099 spark
RUN useradd -u 1099 -g 1099 -d /home/spark -m spark
USER spark

#############################################################
# steps in common
FROM ${TARGET}
# Custom logging
COPY log4j2.properties /opt/bitnami/spark/conf/log4j2.properties

# any files/libraries you need on the cluster, install here ie:
RUN pip install py4j==0.10.9.7
RUN pip install arrow

