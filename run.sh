#!/usr/bin/env bash

ip=`docker-machine ip default`
port="8888"

openavailable(){
	until nc -vz "$1" "$2" &>/dev/null; do
		sleep 1
	done
	open "http://$1:$2/"
}

openavailable $ip $port &

dir=`pwd`
docker run -ti \
	-p 8888:8888 \
	--volume="$dir/shared:/root/shared" \
	kylemcdonald/ml-notebook \
	/bin/bash -c " \
		sudo ln /dev/null /dev/raw1394 ; \
		jupyter notebook --ip='*' --no-browser root/"