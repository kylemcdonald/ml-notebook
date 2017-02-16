#!/usr/bin/env bash

CONTAINER="ml-notebook"
IMAGE="kylemcdonald/$CONTAINER"
IMAGE_FILE="$CONTAINER.tar"
JUPYTER_PORT="8888"
HOST_IP="localhost"

# check if docker is running
docker ps &> /dev/null
DOCKER_RUNNING_CODE=$?
if [ $DOCKER_RUNNING_CODE -ne 0 ]; then
	echo "Docker is not running. Start Docker first."
	exit
fi

# download the image if necessary
if ! ( docker images | grep "$IMAGE" &>/dev/null ) ; then
	if [ -e $IMAGE_FILE ]; then
		echo "The image will be loaded from $IMAGE_FILE (first time only, ~1 minute)."
		docker load < $IMAGE_FILE
	else
		echo "The image will be downloaded from docker (first time only, a few minutes)."
	fi
fi

# if the container wasn't automatically removed last time, remove it
if ( docker stats --no-stream $CONTAINER &>/dev/null ) ; then
	echo "The container is already running, stopping it..."
	docker stop $CONTAINER &>/dev/null
	if ( docker stats --no-stream=true $CONTAINER &>/dev/null ) ; then
		echo "The container still exists, removing it..."
		docker rm $CONTAINER &>/dev/null
	fi
fi

openavailable() {
	# wait up to 10 seconds for jupyter to start
	# this way this loop doesn't run indefinitely
	for i in `seq 1 10`; do
		if [ -e "shared/jupyter.log" ]; then
			JUPYTER_URL=`grep -Eoh "http://$1.+" shared/jupyter.log`
			if [ -n "$JUPYTER_URL" ]; then
				open "$JUPYTER_URL"
				exit
			fi
		fi
		sleep 1
	done
}

# remove the old logfile if it exists
[ -e "shared/jupyter.log" ] && rm "shared/jupyter.log"

# open the browser once the log file has the token
openavailable $HOST_IP &

# run docker
DIR=`pwd`
docker run -ti \
	--rm \
	--name "$CONTAINER" \
	--publish "$JUPYTER_PORT:$JUPYTER_PORT" \
	--env "HOST_IP=$HOST_IP" \
	--workdir "/root/shared" \
	--volume "$DIR/shared:/root/shared" \
	$IMAGE \
	/bin/bash -c " \
		jupyter notebook --ip='*' >jupyter.log 2>&1 & sleep 1 ; \
		echo 'Jupyter is writing to jupyter.log and running at:' ; \
		grep 'http://$HOST_IP' jupyter.log ; \
		echo 'To quit type \"exit\" or Control-D.' ; \
		bash"