#!/usr/bin/env bash

IMAGE="kylemcdonald/ml-notebook"
IMAGE_FILE="ml-notebook.tar"

source update.sh

if [ ! -e $IMAGE_FILE ] ; then
	echo "Saving $IMAGE to $IMAGE_FILE"
	docker save $IMAGE > $IMAGE_FILE
fi
echo "$IMAGE_FILE is ready, zipping everything..."

rm shared/jupyter.log

zip -q -r ../ml-notebook.zip ./
