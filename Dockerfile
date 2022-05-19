FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
      build-essential gcc g++ \
      python3-dev python3-pip python3-setuptools \
      git git-lfs wget
