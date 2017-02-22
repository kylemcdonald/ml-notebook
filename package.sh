#!/usr/bin/env bash

source utils.sh

checkdocker
checkimage $IMAGE $IMAGE_FILE

if [ ! -e $IMAGE_FILE ] ; then
	echo "Saving $IMAGE to $IMAGE_FILE"
	docker save $IMAGE > $IMAGE_FILE
fi
echo "$IMAGE_FILE is ready, zipping everything..."

if [ ! -e $LOG_FILE ] ; then
	rm $LOG_FILE
fi

HASH=`git rev-parse HEAD | cut -c-8`
ZIP_FILE="../ml-notebook-$HASH.zip"

tar cf -q "$ZIP_FILE" ./

echo "Package is ready: $ZIP_FILE"