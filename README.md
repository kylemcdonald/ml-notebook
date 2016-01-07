[![Docker Pulls](https://img.shields.io/docker/pulls/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/) [![Docker Stars](https://img.shields.io/docker/stars/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/)

ml-notebook
===========

This Dockerfile attempts to host multiple machine learning tools (with a focus on Deep Learning) in one Ubuntu 14.04 image, and to provide an interface via Jupyter.

Deep Learning:
- Theano with Keras and Lasagne: dcgan (o)
- Caffe and pycaffe: Deep Dream by Google
- Torch: char-rnn (o) by Andrej Karpathy, neural-style (o) by Justin Johnson
- Chainer

General: 
- Jupyter
- gensim: word2vec (o) example (with word2vec db)
- sklearn: t-SNE (o) visualization example

Usage
-----

I've only tested this on OSX. Somethign similar should work on Linux, and I'm not sure about the process for Windows.

1. Install [Docker](http://docker.com/).
2. Run the "Docker Quickstart Terminal".
3. Clone this repo and run `run.sh`.

```
git clone http://github.com/kylemcdonald/ml-notebook
cd ml-notebook && ./run.sh
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

Once this is working by adding things manually, I would like to create a script that compiles multiple Dockerfiles into a single file with some filtering like this:

```
perl -pe 's/\s*#.+//' Dockerfile | perl -pe 's/\\\s*\n/ /' | perl -pe 's/[ \t]+/ /g' | grep 'RUN\|ENV'
```

Acknowledgements
----------------

This work is heavily based on Dockerfiles from [Kaixhin](https://github.com/Kaixhin/dockerfiles/).