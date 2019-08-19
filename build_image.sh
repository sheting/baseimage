#!/bin/bash

build_image() {
	echo "*************  CHECK PARA  ************"
	echo "dir: $dir"
	echo "version: $version"
	echo "REGISTRY_NAME: $REGISTRY_NAME"
	if [[ $dir == "" || $version == "" || $REGISTRY_NAME == "" ]]; then
		echo "!!!Error: Missing PARA. dir OR version OR REGISTRY_NAME"
		return 1
	fi
	
	source $dir/image_list.sh
	
	for (( i = 0; i < ${#image_names[@]}; i++ )); do
		START=$(date +"%s")
		image="${image_names[$i]}"
		file="${docker_files[$i]}"
		IMAGE_LOCAL=$image:$version
		echo
		echo "*************  BUILD IMAGE : $IMAGE_LOCAL ************"
		echo "docker build --no-cache -f $dir/$version/$file -t $IMAGE_LOCAL ./$dir/$version"
		#docker build --no-cache -f $dir/$version/$file -t $IMAGE_LOCAL ./$dir/$version
		docker build --no-cache -f $dir/$version/$file -t $IMAGE_LOCAL ./$build_dir
		if [ $? != 0 ]; then
	        echo "!!!Error: Build $IMAGE_LOCAL failed."
	        return 1
	    fi
	    BUILD_COMPLETE=$(date +"%s")
	   	echo "*************  PUSH IMAGE : $IMAGE_LOCAL ************"
	    cd deployment/script/utils
	    registry=$REGISTRY_NAME ./push_image.env.sh $IMAGE_LOCAL
	    res=$?
	    cd - &> /dev/null
	    if [ $res != 0 ]; then
	    	echo "!!!Error: Push $IMAGE_LOCAL failed."
	    	return 1
	    fi
	    FINISH=$(date +"%s")
	    echo
		echo "##### Time elapsed($IMAGE_LOCAL) : ($(($FINISH - $START)) = $(($BUILD_COMPLETE - $START)) + $(($FINISH - $BUILD_COMPLETE)))"
	done
	return 0
}

DIR_LIST_FILE=${1:-'dirs_list'}
echo "DIR_LIST_FILE: $DIR_LIST_FILE"

source $DIR_LIST_FILE.sh

for (( i = 0; i < ${#dir_list[@]}; i++ )); do
	dir="${dir_list[$i]}" version="${version_list[$i]}" REGISTRY_NAME="${registry_list[$i]}" 
	echo
	echo "########################################"
	echo "############  $dir BEGIN  ##############"
	echo "########################################"
	echo "dir=$dir version=$version REGISTRY_NAME=$REGISTRY_NAME build_dir="${build_dir[$i]}" build_image > $dir/build_image.log"
	dir=$dir version=$version REGISTRY_NAME=$REGISTRY_NAME build_dir="${build_dir[$i]}" build_image 2>&1 | tee $dir/build_image.log 
	if [ $? != 0 ]; then
		echo "!!!Error: Build $dir folder failed."
	   	exit 1
	fi
done


