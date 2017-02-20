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

This is only tested this on OSX. Something similar should work on Linux, and possibly Windows with some changes.

1. Install [Docker](https://www.docker.com/). On Mac, use Docker for Mac.
2. Clone this repository. `git clone https://github.com/kylemcdonald/ml-notebook.git && cd ml-notebook`
3. (Optional) Run `./update.sh` __Note__: this downloads 2+GB of data and examples. If you just want to look around, browse [ml-examples](https://github.com/kylemcdonald/ml-examples).
4. Run `./run.sh` __Note__: this downloads another 2+GB of data, a pre-built image from Docker.

Type `Ctrl-D` to exit the ml-notebook Docker. If you accidentally close the Terminal, the Jupyter notebook will keep running in the background. Whenever you want to run the environment again, just call `./run.sh`. Calling `./run.sh` when ml-notebook is running in the background will restart ml-notebook.

Acknowledgements
----------------

Some of the deep learning toolkits are built based on Dockerfiles from [Kaixhin](https://github.com/Kaixhin/dockerfiles/).
