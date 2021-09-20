FROM nvcr.io/hpc/gromacs:2021

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 PATH=/opt/conda/bin:$PATH
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing && \
  apt-get install -y wget bzip2 curl build-essential \
  ca-certificates git libglib2.0-0 libxext6 libsm6 \
  libxrender1 git mercurial subversion software-properties-common && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update --fix-missing && \
  apt-get install -y python3.7 python3.7-distutils python3.7-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/bowman-lab/fast.git /fast

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.7 get-pip.py

RUN ln -s /usr/bin/python3.7 /usr/bin/python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 10
RUN update-alternatives --config python

RUN python3.7 -m pip install \
    numpy \
    cython
RUN python3.7 -m pip install \
    mdtraj
RUN python3.7 -m pip install \
    git+https://github.com/bowman-lab/enspara
