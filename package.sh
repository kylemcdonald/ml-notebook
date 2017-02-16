#!/usr/bin/env bash

# check if docker is running
checkdocker() {
	docker ps &> /dev/null
	DOCKER_RUNNING_CODE=$?
	if [ $DOCKER_RUNNING_CODE -ne 0 ]; then
		echo "Docker is not running. Start Docker first."
		exit
	fi
}

checkdocker

IMAGE="kylemcdonald/ml-notebook"
IMAGE_FILE="ml-notebook.tar"
LOG_FILE="shared/jupyter.log"

# source update.sh

if [ ! -e $IMAGE_FILE ] ; then
	echo "Saving $IMAGE to $IMAGE_FILE"
	docker save $IMAGE > $IMAGE_FILE
fi
echo "$IMAGE_FILE is ready, zipping everything..."

if [ ! -e $LOG_FILE ] ; then
	rm $LOG_FILE
fi

HASH=`git rev-parse HEAD | cut -c-8`
ZIPFILE="../ml-notebook-$HASH.zip"

zip -q -r "$ZIPFILE" ./

echo "Package is ready: $ZIPFILE"