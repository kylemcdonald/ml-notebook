# start from tensorflow base image
FROM gcr.io/tensorflow/tensorflow

RUN apt-get update

# [ pandas ]

RUN pip install pandas

# [ keras + theano ]
# https://github.com/fchollet/keras/blob/master/docker/Dockerfile

RUN apt-get install -y \
  wget \
  git \
  libhdf5-dev \
  g++ \
  graphviz > /dev/null

RUN pip install h5py
RUN pip install git+git://github.com/fchollet/keras.git

# [ gensim ]

RUN pip install gensim

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

# the version on pip is older than this version on GitHub
RUN pip install git+git://github.com/ptone/pyosc.git

# [ Cleanup ]
# Only run this once at the end.

RUN apt-get clean autoclean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*