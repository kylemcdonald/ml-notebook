#!/usr/bin/env bash

# load the image if it's available
echo "Loading the ml-notebook image (30-60 seconds)."
docker load < ml-notebook.tar
echo "Done loading the ml-notebook image. Now calling ./run.sh"
./run.sh