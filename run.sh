#!/usr/bin/env bash

source utils.sh

# if the container wasn't automatically removed last time, remove it
checkcontainer() {
	CONTAINER=$1
	if ( docker stats --no-stream $CONTAINER &>/dev/null ) ; then
		echo "The container is already running, stopping it..."
		docker stop $CONTAINER &>/dev/null
		if ( docker stats --no-stream $CONTAINER &>/dev/null ) ; then
			echo "The container still exists, removing it..."
			docker rm $CONTAINER &>/dev/null
		fi
	fi
}

# open the browser once the log file has the token
openavailable() {
	HOST_IP=$1
	LOG_FILE=$2
	# remove the old log file if it exists
	[ -e $LOG_FILE ] && rm $LOG_FILE
	# wait up to 10 seconds for jupyter to start
	# this way this loop doesn't run indefinitely
	for i in `seq 1 10`; do
		if [ -e $LOG_FILE ]; then
			JUPYTER_URL=`grep -Eoh "http://$HOST_IP.+" $LOG_FILE`
			if [ -n "$JUPYTER_URL" ]; then
				open "$JUPYTER_URL"
				exit
			fi
		fi
		sleep 1
	done
}

# run docker
runcontainer() {
	CONTAINER=$1
	HOST_IP=$2
	JUPYTER_PORT=$3
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
			sleep 1 ; grep 'http://$HOST_IP' jupyter.log ; \
			echo 'To quit type \"exit\" or Control-D.' ; \
			bash"
}

JUPYTER_PORT="8888"
HOST_IP="localhost"

checkdocker
checkimage $IMAGE $IMAGE_FILE
checkcontainer $CONTAINER
openavailable $HOST_IP $LOG_FILE &
runcontainer $CONTAINER $HOST_IP $JUPYTER_PORT