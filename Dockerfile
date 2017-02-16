FROM ubuntu:14.04

RUN apt-get update

# [ tensorflow ]
# https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/Dockerfile

RUN apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  libfreetype6-dev \
  libpng12-dev \
  libzmq3-dev \
  pkg-config \
  python \
  python-dev \
  rsync \
  software-properties-common \
  unzip

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  rm get-pip.py

RUN pip --no-cache-dir install \
  ipykernel \
  jupyter \
  matplotlib \
  numpy \
  scipy \
  sklearn \
  pandas \
  Pillow \
  tensorflow

RUN python -m ipykernel.kernelspec

# TensorBoard
EXPOSE 6006

# IPython
EXPOSE 8888

# [ pandas ]

RUN pip --no-cache-dir install pandas

# [ keras + theano ]
# https://github.com/fchollet/keras/blob/master/docker/Dockerfile

RUN apt-get install -y \
  wget \
  git \
  libhdf5-dev \
  g++ \
  graphviz > /dev/null

RUN pip --no-cache-dir install h5py
RUN pip --no-cache-dir install git+git://github.com/fchollet/keras.git

# [ gensim ]

RUN pip --no-cache-dir install gensim

# [ torch ]
# https://github.com/Kaixhin/dockerfiles/blob/master/torch/Dockerfile

# Install git, apt-add-repository and dependencies for iTorch
RUN apt-get install -y \
  git \
  software-properties-common \
  ipython3 \
  libssl-dev \
  libzmq3-dev \
  python-zmq \
  python-pip > /dev/null

RUN git clone https://github.com/torch/distro.git /root/torch --recursive && \
  cd /root/torch && \
  bash install-deps > /dev/null && \
  ./install.sh -b > /dev/null

ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
ENV LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
ENV PATH=/root/torch/install/bin:$PATH
ENV LD_LIBRARY_PATH=/root/torch/install/lib:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH=/root/torch/install/lib:$DYLD_LIBRARY_PATH
ENV LUA_CPATH='/root/torch/install/lib/?.so;'$LUA_CPATH

# [ pyOSC ]

# this version is more up to date than pip
RUN pip --no-cache-dir install git+git://github.com/ptone/pyosc.git

# [ cleanup ]
# Only run this once at the end.

RUN apt-get clean autoclean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*