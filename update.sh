#!/usr/bin/env bash

source utils.sh

checkdocker
checkimage $IMAGE $IMAGE_FILE

docker pull kylemcdonald/ml-notebook

git pull origin master

# into shared
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

cd ..
# out of shared