#!/usr/bin/env bash

# set up docker
# eval "$(docker-machine env --shell=bash default)"

jupyterport="8888"
ip=`docker-machine ip default`

openavailable(){
	# echo "Opening http://$1:$2/ once it is available..."
	# wait for nc to connect to the port
	# todo: windows?
	until nc -vz "$1" "$2" &>/dev/null; do
		sleep 1
	done
	# todo: windows and linux
	open "http://$1:$2/"
}

openavailable $ip $jupyterport &

dir=`pwd`
docker run -ti \
	--rm=true \
	--name="ml-notebook" \
	--publish="$jupyterport:$jupyterport" \
	--env "HOST_IP=$ip" \
	--workdir="/root/shared" \
	--volume="$dir/shared:/root/shared" \
	kylemcdonald/ml-notebook \
	/bin/bash -c " \
		sudo ln /dev/null /dev/raw1394 ; \
		jupyter notebook --ip='*' --no-browser > jupyter.log 2>&1 & \
		echo 'Jupyter is at http://$ip:$jupyterport/ and writing to jupyter.log' ; \
		bash"