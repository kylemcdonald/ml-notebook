#!/bin/bash
ip=`docker-machine ip default`
sleep 2 && open "http://$ip:8888/" &
dir=`pwd`
docker run -ti \
	-p 8888:8888 \
	--volume="$dir/shared:/root/shared" \
	kylemcdonald/ml-notebook \
	/bin/bash -c " \
		sudo ln /dev/null /dev/raw1394 ; \
		jupyter notebook --ip='*' --no-browser root/"