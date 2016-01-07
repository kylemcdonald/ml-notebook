# Start with Ubuntu base image
FROM ubuntu:14.04

# [ Caffe ]
# From first half of https://github.com/Kaixhin/dockerfiles/blob/master/digits/Dockerfile

# Install git, bc and dependencies
RUN apt-get update && apt-get install -y \
  git \
  bc \
  cmake \
  libgflags-dev \
  libgoogle-glog-dev \
  libopencv-dev \
  libleveldb-dev \
  libsnappy-dev \
  liblmdb-dev \
  libhdf5-serial-dev \
  libprotobuf-dev \
  protobuf-compiler \
  libatlas-base-dev \
  python-dev \
  python-pip \
  python-numpy \
  gfortran

# Install boost
RUN apt-get install -y --no-install-recommends libboost-all-dev

# Clone NVIDIA Caffe repo and move into it
RUN cd /root && git clone --branch caffe-0.14 https://github.com/NVIDIA/caffe.git && cd caffe && \
# Install python dependencies
  cat python/requirements.txt | xargs -n1 pip install && \
# Make and move into build directory
  mkdir build && cd build && \
# CMake
  cmake .. && \
# Make
  make -j"$(nproc)"
# Set CAFFE_HOME
ENV CAFFE_HOME /root/caffe
ENV PYTHONPATH /root/caffe/python:$PYTHONPATH

# [ Theano ]

# Install build-essential, git, python-dev, pip and other dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  python-dev \
#  libopenblas-dev \ # this causes an error with Theano afaict
  python-pip \
  python-nose \
  python-numpy \
  python-scipy

# Install bleeding-edge Theano
RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git

# [ Lasagne ]

# Install bleeding-edge Lasagne
RUN pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip

# [ Keras ]

# Install dependencies
RUN apt-get update && apt-get install -y \
  libhdf5-dev \
  python-h5py \
  python-yaml

# Upgrade six
RUN pip install --upgrade six

# Clone Keras repo and move into it
RUN cd /root && git clone https://github.com/fchollet/keras.git && cd keras && \
  # Install
  python setup.py install

# Set ~/keras as working directory
# WORKDIR /root/keras

# [ Torch ]

# Install curl and dependencies for iTorch
RUN apt-get update && apt-get install -y \
  curl \
  ipython3 \
  python-zmq

# Run Torch7 installation scripts
RUN curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN cd ~/torch; ./install.sh

# Set ~/torch as working directory
# WORKDIR /root/torch

# Export environment variables manually
ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-alpha/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua' \
  LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so' \
  PATH=/root/torch/install/bin:$PATH \
  LD_LIBRARY_PATH=/root/torch/install/lib:$LD_LIBRARY_PATH \
  DYLD_LIBRARY_PATH=/root/torch/install/lib:$DYLD_LIBRARY_PATH

# [ Chainer ]

RUN apt-get install -y \
  ccache \
  curl \
  g++ \
  gfortran \
  git \
  libhdf5-dev
ENV PATH /usr/lib/ccache:$PATH
RUN apt-get install -y \
  python-pip \
  python-dev
# RUN pip install numpy==1.10.2 # more recent version already installed above
RUN pip install chainer

# [ gensim, sklearn ]

RUN pip install \
  gensim \
  sklearn

# [ IPython / Jupyter]

RUN pip install \
  pexpect \
  simplegeneric \
  jupyter

# Cleanup

RUN apt-get clean autoclean
RUN apt-get autoremove -y
