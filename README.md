[![Docker Pulls](https://img.shields.io/docker/pulls/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/) [![Docker Stars](https://img.shields.io/docker/stars/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/)

ml-notebook
===========

This Dockerfile attempts to host multiple machine learning tools (with a focus on Deep Learning) in one Ubuntu 14.04 image, and to provide an interface via Jupyter. It is meant to be used in combination with the [ml-examples](https://github.com/kylemcdonald/ml-examples) repository.

Deep Learning:
- Theano with Keras and Lasagne
- Caffe and pycaffe
- Torch
- Chainer

General: 
- Jupyter
- gensim
- sklearn

Usage
-----

This is only tested this on OSX. Something similar should work on Linux, and possibly Windows.

1. Install [Docker](http://docker.com/).
2. Clone this repo and run `run.sh`.

```
$ git clone https://github.com/kylemcdonald/ml-notebook.git
$ cd ml-notebook && ./run.sh
```

Adding more memory or CPUs
--------------------------

1. Stop the Docker VM by running `docker-machine stop default`.
2. Open up VirtualBox and click on the "default" machine. Under "System" make the changes you want to see. E.g., change the memory to 8192MB and CPUs to 4.
3. Run `docker-machine start default` to restart the VM.
4. Run `run.sh` and check the free memory and number of processors:

```
$ root@a86d27857c85:~/shared# nproc 
4
$ root@a86d27857c85:~/shared# free -h
             total       used       free     shared    buffers     cached
Mem:          7.8G       295M       7.5G       124M        10M       150M
...
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

It would be interesting to use `avahi-daemon` to identify the IP address of the host automatically. But it seems [difficult](http://grokbase.com/t/gg/docker-user/155wz59qrn/docker-avahi-daemon-service-fails-to-start-when-running-multiple-containers-on-the-same-machine). Instead you should find the host name with `docker-machine ip default`.

Once this is working by adding things manually, I would like to create a script that compiles multiple Dockerfiles into a single file with some filtering like this:

```
perl -pe 's/\s*#.+//' Dockerfile | perl -pe 's/\\\s*\n/ /' | perl -pe 's/[ \t]+/ /g' | grep 'RUN\|ENV'
```

Acknowledgements
----------------

This work is heavily based on Dockerfiles from [Kaixhin](https://github.com/Kaixhin/dockerfiles/).