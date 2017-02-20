#!/usr/bin/env bash

CONTAINER="ml-notebook"
IMAGE="kylemcdonald/$CONTAINER"
IMAGE_FILE="$CONTAINER.tar"
LOG_FILE="shared/jupyter.log"

# check if docker is running
checkdocker() {
	docker ps &> /dev/null
	DOCKER_RUNNING_CODE=$?
	if [ $DOCKER_RUNNING_CODE -ne 0 ]; then
		echo "Docker is not running. Start Docker first."
		exit
	fi
}

# download the image if necessary
checkimage() {
	IMAGE=$1
	IMAGE_FILE=$2
	if ! ( docker images | grep "$IMAGE" &>/dev/null ) ; then
		if [ -e $IMAGE_FILE ]; then
			echo "The image will be loaded from $IMAGE_FILE (first time only, ~1 minute)."
			docker load < $IMAGE_FILE
		else
			echo "The image will be downloaded from docker (first time only, a few minutes)."
			docker pull $IMAGE
		fi
	fi
}