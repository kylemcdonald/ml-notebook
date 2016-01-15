#!/usr/bin/env bash

git pull origin master

source start-docker.sh

if ! ( docker images | grep "$IMAGE" &>/dev/null ) ; then
	docker pull $IMAGE
fi

cd shared
if [ ! -d ml-examples ] ; then
	git clone https://github.com/kylemcdonald/ml-examples.git
fi
cd ml-examples
./setup.sh
cd - &>/dev/null

if [ ! -d ml-examples-oF ] ; then
	git clone https://github.com/yusuketomoto/ml-examples-oF.git
fi
cd ml-examples-oF
./setup.sh
cd - &>/dev/null

cd ../..