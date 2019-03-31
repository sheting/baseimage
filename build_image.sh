#!/bin/bash

build_image() {
	echo "dir: $dir"
	echo "version: $version"
	echo "REGISTRY_NAME: $REGISTRY_NAME"
	echo "*************  CHECK PARA  ************"
	if [[ $dir == "" || $version == "" || $REGISTRY_NAME == "" ]]; then
		echo "!!!Error: Missing PARA. dir OR version OR REGISTRY_NAME"
		exit 1
	fi
	
	source $dir/image_list.sh
	
	for (( i = 0; i < ${#image_names[@]}; i++ )); do
		image="${image_names[$i]}"
		file="${docker_files[$i]}"
		IMAGE_LOCAL=$image:$version
		echo "*************  BUILD IMAGE : $IMAGE_LOCAL ************"
		echo "docker build --no-cache -f $dir/$version/$file -t $IMAGE_LOCAL ./$dir/$version"
		docker build --no-cache -f $dir/$version/$file -t $IMAGE_LOCAL ./$dir/$version
		if [ $? != 0 ]; then
	        echo "!!!Error: Build $IMAGE_LOCAL failed."
	        exit 1
	    fi
	   	echo "*************  PUSH IMAGE : $IMAGE_LOCAL ************"
	    cd deployment/script/utils
	    registry=$REGISTRY_NAME ./push_image.env.sh $1
	    res=$?
	    cd - &> /dev/null
	    if [ $res != 0 ]; then
	    	echo "!!!Error: Push $IMAGE_LOCAL failed."
	        exit 1
	    fi
	done
}

source dirs_list.sh

for (( i = 0; i < ${#dir_list[@]}; i++ )); do
	dir="${dir_list[$i]}" version="${version_list[$i]}" REGISTRY_NAME="${registry_list[$i]}" 
	echo "dir=$dir version=$version REGISTRY_NAME=$REGISTRY_NAME build_image > $dir/build_image.log"
	dir=$dir version=$version REGISTRY_NAME=$REGISTRY_NAME build_image
	if [ $? != 0 ]; then
		echo "!!!Error: Build $dir folder failed."
	   	exit 1
	fi
done


