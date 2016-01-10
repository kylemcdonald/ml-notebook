[![Docker Pulls](https://img.shields.io/docker/pulls/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/) [![Docker Stars](https://img.shields.io/docker/stars/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/)

ml-notebook
===========

This Dockerfile attempts to host multiple machine learning tools (with a focus on Deep Learning) in one Ubuntu 14.04 image, and to provide an interface via Jupyter.

Deep Learning:
- Theano with Keras and Lasagne
- Caffe and pycaffe
- Torch
- Chainer

General: 
- Jupyter
- gensim
- sklearn

For a collection of examples to use with ml-notebook, check out [ml-examples](https://github.com/kylemcdonald/ml-examples).

Usage
-----

I've only tested this on OSX. Something similar should work on Linux, and I'm not sure about the process for Windows.

1. Install [Docker](http://docker.com/).
2. Clone this repo and run `run.sh`.

```
$ git clone https://github.com/kylemcdonald/ml-notebook.git
$ cd ml-notebook && ./run.sh
```

Build notes
-----------

The Chainer portion was based on this process:

```
$ git clone https://github.com/pfnet/chainer-test.git && cd chainer-test
$ ./make_docker.py --base ubuntu14_py2 --numpy numpy110 --cuda none --cudnn none
$ open -t Dockerfile
```

And removing `RUN pip install numpy==1.10.2`

Next steps
----------

I'd like to use avahi-daemon to make the IP address of the host. But it seems [difficult](http://grokbase.com/t/gg/docker-user/155wz59qrn/docker-avahi-daemon-service-fails-to-start-when-running-multiple-containers-on-the-same-machine). It might make sense to add a line to the host file instead (if one doesn't already exist), but this requires a password.

Once this is working by adding things manually, I would like to create a script that compiles multiple Dockerfiles into a single file with some filtering like this:

```
perl -pe 's/\s*#.+//' Dockerfile | perl -pe 's/\\\s*\n/ /' | perl -pe 's/[ \t]+/ /g' | grep 'RUN\|ENV'
```

Acknowledgements
----------------

This work is heavily based on Dockerfiles from [Kaixhin](https://github.com/Kaixhin/dockerfiles/).