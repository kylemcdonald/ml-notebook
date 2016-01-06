#!/bin/bash
ip=`docker-machine ip default`
open "http://$ip:8888/"
docker run -ti -P kylemcdonald/ml-notebook