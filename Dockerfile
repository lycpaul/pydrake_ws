# -*- mode: dockerfile -*-
# vi: set ft=dockerfile :

# Copyright 2020 Massachusetts Institute of Technology.
# Licensed under the BSD 3-Clause License. See LICENSE.TXT for details.

# cd $(git rev-parse --show-toplevel)
# docker build -f scripts/docker/Dockerfile \
#   -t robotlocomotion/manipulation:latest .
#
# docker run -i -p 7000:7000 -p 8888:8888 -t -v $(pwd):/root/manipulation \
#   -w /root/manipulation robotlocomotion/manipulation:latest
#
# docker login
# docker push robotlocomotion/manipulation:latest

FROM robotlocomotion/drake:focal
ARG DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash
EXPOSE 7000/tcp
EXPOSE 6000/tcp
EXPOSE 8888/tcp

LABEL org.opencontainers.image.authors="Russ Tedrake"
LABEL org.opencontainers.image.description="A systems theory perspective on perception, planning, and control"
LABEL org.opencontainers.image.licenses="BSD-3-Clause"
LABEL org.opencontainers.image.source="https://github.com/RussTedrake/manipulation.git"
LABEL org.opencontainers.image.title="Robot Manipulation"
LABEL org.opencontainers.image.url="http://manipulation.csail.mit.edu/"
LABEL org.opencontainers.image.vendor="Massachusetts Institute of Technology"

# install apt-utils net-tools
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils net-tools

# install and setup locales
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# install and setup pip
RUN set -xe \
    && apt-get update \
    && apt-get install -y python3-pip

RUN python3 -m pip install jupyterlab altair plotly

RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && apt-get install -y nodejs
RUN python3 -m pip install --upgrade ipywidgets

# Method 1: starting jupyter-lab, TODO: unable to connect from vscode
# CMD jupyter nbextension enable --py --sys-prefix widgetsnbextension
# CMD jupyter labextension install @jupyter-widgets/jupyterlab-manager
# CMD jupyter-lab --port=8888 --no-browser --ip=0.0.0.0 --allow-root

# Method 2: starting jupyter-notebook
CMD jupyter-notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root