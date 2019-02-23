# --- base image: pyspark jupyter container
#     see for all containers: https://hub.docker.com/u/jupyter/
#     This serves as the basis for our docker image.
#     tag 45b8529a6bfc from: 2019-02-14
FROM jupyter/pyspark-notebook:45b8529a6bfc

# --- me
MAINTAINER Max Baak <maxbaak@gmail.com>

# --- switch to root user
USER root

# --- link sh to bash
SHELL ["/bin/bash", "-c"]

# --- packages for root installation
RUN apt-get -y update && \
    apt-get --no-install-recommends -y install file dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev gfortran libfftw3-dev libxml2-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# --- install ROOT; turn off stuff we do not need
RUN cd /tmp && \ 
    wget https://root.cern.ch/download/root_v6.16.00.source.tar.gz && \
    tar xvfz root_v6.16.00.source.tar.gz && \
    mkdir /opt/root && \
    cd /opt/root && \
    cmake /tmp/root-6.16.00/ -Droofit=ON -Dminuit2=ON -Dxrootd=OFF -Drfio=OFF -Dpythia6=OFF -Dpythia8=OFF -Dtmva=ON && \
    cmake --build . -- -j3 && \
    cp /tmp/root-6.16.00/cmake/modules/RootNewMacros.cmake /tmp && \
    rm -Rf /tmp/root-6.16.00 /tmp/root_v6.16.00.source.tar.gz && \
    cd /opt/root && \
    rm -Rf `find . -name '*CMakeFiles' ` && \
    rm -Rf `find . -name '*src' ` && \
    mkdir -p /tmp/root-6.16.00/cmake/modules/ && \
    mv /tmp/RootNewMacros.cmake /tmp/root-6.16.00/cmake/modules/

# --- append sourcing of ROOT env to bashrc
COPY bashrc_appendum /tmp/
RUN cat /tmp/bashrc_appendum >> "${HOME}"/.bashrc && rm /tmp/bashrc_appendum

# --- switch to jovyan user
USER $NB_UID

# --- install additional ROOT related packages
RUN source /opt/root/bin/thisroot.sh && \
    pip install root_numpy==4.7.3 && \
    pip install rootpy==1.0.1

# --- set relevant ROOT environment variables, so root is known in jupyter at startup
ENV ROOTSYS "/opt/root"
ENV LD_LIBRARY_PATH "${ROOTSYS}/lib:${LD_LIBRARY_PATH}"
ENV JUPYTER_PATH "${ROOTSYS}/etc/notebook:${JUPYTER_PATH}"
ENV PYTHONPATH "${ROOTSYS}/lib:${PYTHONPATH}"
