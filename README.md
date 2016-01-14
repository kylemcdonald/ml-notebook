[![Docker Pulls](https://img.shields.io/docker/pulls/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/) [![Docker Stars](https://img.shields.io/docker/stars/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/)

ml-notebook
===========

This project is aimed at providing an accessible and reproducible environment for a variety of machine learning toolkits, with a focus on deep learning toolkits. Instead of asking you to follow a set of complex setup instructions, ml-notebook asks you to wait while a tested, pre-built image is installed.

The following tools are available inside the Ubuntu 14.04 image, with Jupyter as an interface:

General:
- [matplotlib](http://matplotlib.org/)*
- [scipy](http://www.scipy.org/)*
- [numpy](http://www.numpy.org/)*
- [pyOSC](https://github.com/ptone/pyosc/blob/master/OSC.py)
- [Jupyter](http://jupyter.org/)

Machine Learning:
- [gensim](https://radimrehurek.com/gensim/)
- [scikit-learn](http://scikit-learn.org/stable/)
- [scipy](http://www.scipy.org/)*
- [pandas](http://pandas.pydata.org/)*

Deep Learning:
- [Caffe](http://caffe.berkeleyvision.org/) (with pycaffe)
- [Chainer](http://chainer.org/)
- [TensorFlow](http://tensorflow.org)
- [Theano](http://deeplearning.net/software/theano/) (with [Keras](http://keras.io/) and [Lasagne](https://github.com/Lasagne/Lasagne))
- [Torch](http://torch.ch/)

*These are requirements of other libraries, but also interesting in their own right.

Usage
-----

This is only tested this on OSX. Something similar should work on Linux, and possibly Windows.

1. Install [Docker](https://www.docker.com/docker-toolbox/).
2. Clone this repository.
3. (Optional) Run `./update.sh` __Notice__: this downloads almost 2GB of data and examples. If you just want to look around, browse [ml-examples](https://github.com/kylemcdonald/ml-examples).
4. Run `./run.sh` __Notice__: this downloads another 2GB of data, a pre-built image from Docker.

After installing Docker, steps 2-4 look like this:

```
$ git clone https://github.com/kylemcdonald/ml-notebook.git && cd ml-notebook
$ ./update.sh
$ ./run.sh
```

Type `ctrl+d` to exit ml-notebook. If you accidentally close the Terminal, the Jupyter notebook will keep running in the background. Whenever you want to run the environment again, just call `./run.sh`. Calling `./run.sh` when ml-notebook is running in the background will restart ml-notebook.

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

And removing `RUN pip install numpy==1.10.2`.

The TensorFlow portion was based on the official [TensorFlow Dockerfile](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/Dockerfile).

Acknowledgements
----------------

Most of the deep learning toolkits are installed based on Dockerfiles from [Kaixhin](https://github.com/Kaixhin/dockerfiles/).
