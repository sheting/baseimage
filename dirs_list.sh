#!/bin/bash

declare -a dir_list=(
	'fe_static'
	'fe_ionic'
	'fe_vue'
	'nodejs'
);

declare -a version_list=(
	'1.14.2'
	'3.0.0'
	'3.6.2'
	'3.8'
);

declare -a build_dir=(
	'fe_build_env'
	'fe_build_env'
	'fe_build_env'
	'nodejs'
);

declare -a registry_list=(
	'ecr'
	'ecr'
	'ecr'
	'ecr'
);