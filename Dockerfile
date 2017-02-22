FROM ubuntu:14.04

# [ tensorflow ]
# https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/Dockerfile

RUN apt-get update; \
  apt-get install -y --no-install-recommends \
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
    unzip; \
  apt-get clean autoclean; \
  apt-get autoremove -y; \
  rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py; \
  python get-pip.py; \
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
    tensorflow; \
  python -m ipykernel.kernelspec

# TensorBoard
EXPOSE 6006

# IPython
EXPOSE 8888

# [ pandas ]

RUN pip --no-cache-dir install pandas

# [ keras + theano ]
# https://github.com/fchollet/keras/blob/master/docker/Dockerfile

RUN apt-get update; \
  apt-get install -y \
    wget \
    git \
    libhdf5-dev \
    g++ \
    graphviz; \
  apt-get clean autoclean; \
  apt-get autoremove -y; \
  rm -rf /var/lib/apt/lists/*

RUN pip --no-cache-dir install h5py git+git://github.com/fchollet/keras.git

# [ gensim ]

RUN pip --no-cache-dir install gensim

# [ torch ]
# https://github.com/Kaixhin/dockerfiles/blob/master/torch/Dockerfile

# Install git, apt-add-repository and dependencies for iTorch
RUN apt-get update; \
  apt-get install -y \
    git \
    software-properties-common \
    ipython3 \
    libssl-dev \
    libzmq3-dev \
    python-zmq \
    python-pip; \
  apt-get clean autoclean; \
  apt-get autoremove -y; \
  rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/torch/distro.git /root/torch --recursive; \
  cd /root/torch; bash install-deps; ./install.sh -b

ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
ENV LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
ENV PATH=/root/torch/install/bin:$PATH
ENV LD_LIBRARY_PATH=/root/torch/install/lib:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH=/root/torch/install/lib:$DYLD_LIBRARY_PATH
ENV LUA_CPATH='/root/torch/install/lib/?.so;'$LUA_CPATH

RUN git clone https://github.com/facebook/iTorch.git ; \
  cd iTorch ; luarocks make ; \
  cd .. ; rm -rf iTorch

# [ pyOSC ]

# this version is more up to date than pip
RUN pip --no-cache-dir install git+git://github.com/ptone/pyosc.git

# [ dlib ]

RUN apt-get update; \
  apt-get install -y \
    libopenblas-dev \
    libboost-python-dev \
    liblapack-dev; \
  git clone https://github.com/davisking/dlib.git /root/dlib; \
  cd /root/dlib; mkdir build; cd build; cmake ..; cmake --build .; \
  cd /root/dlib; python setup.py install; \
  cd /root ; rm -rf dlib; \
  apt-get clean autoclean; \
  apt-get autoremove -y; \
  rm -rf /var/lib/apt/lists/*

# [ Multicore-TSNE ]

RUN git clone https://github.com/DmitryUlyanov/Multicore-TSNE.git ; \
  cd Multicore-TSNE ; \
  pip --no-cache-dir install -r requirements.txt ; \
  python setup.py install ; \
  cd .. ; rm -rf Multicore-TSNE

RUN pip --no-cache-dir install \
    scikit-image

# [ lapjv ]

RUN pip --no-cache-dir install \
  cython \
  git+git://github.com/gatagat/lapjv.git

# [ torch-rnn ]

RUN git clone https://github.com/deepmind/torch-hdf5 ; \
  cd torch-hdf5 ; \
  luarocks make hdf5-0-0.rockspec ; \
  cd .. ; \
  rm -rf torch-hdf5

# [ neuraltalk2 ]

RUN apt-get update; \
  apt-get install -y \
    libprotobuf-dev \
    protobuf-compiler ;\
  luarocks install loadcaffe