[![Docker Pulls](https://img.shields.io/docker/pulls/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/)
[![Docker Stars](https://img.shields.io/docker/stars/kylemcdonald/ml-notebook.svg)](https://hub.docker.com/r/kylemcdonald/ml-notebook/)

# ml-notebook (WIP)

This Dockerfile attempts to host multiple machine learning tools (with a focus on Deep Learning) in one Ubuntu 14.04 image, and to provide an interface via Jupyter.

- gensim (o)
    - word2vec (o) example
- sklearn (o)
    - t-SNE (o) visualization example
- Torch (x)
    - char-rnn (o) by Andrej Karpathy
    - neural-style (o) by Justin Johnson
- Caffe (x) and pycaffe (o)
    - Deep Dream by Google
- Chainer (o)
- Theano (x) with Keras (x) and Lasagne (x)
    - dcgan (o)
- Jupyter (x)

## Usage

First, install [Docker](http://docker.com/). Then clone this repo and run `run.sh`:

```
git clone http://github.com/kylemcdonald/ml-notebook
cd ml-notebook && ./run.sh
```

## Next steps

Once this is working by adding things manually, I would like to create a script that compiles multiple Dockerfiles into a single file with some filtering like this:

```
perl -pe 's/\s*#.+//' Dockerfile | perl -pe 's/\\\s*\n/ /' | perl -pe 's/[ \t]+/ /g' | grep 'RUN\|ENV'
```

## Acknowledgements

This work is heavily based on Dockerfiles from [Kaixhin](https://github.com/Kaixhin/dockerfiles/).