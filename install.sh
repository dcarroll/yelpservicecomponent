#!/usr/bin/env bash

curDir=$(pwd)
tempDir=""

useTempDir() {
	dir=`mktemp -d -t yelp.XXXXXX`
	tempDir=$dir #"/metadata"
	umask 000
	#mkdir -p $tempDir
	cd $tempDir
}

has_class_file() {
	local res=$( (force fetch -t $1 -n $2) 2>&1 )
	if [[ $res == "ERROR"* ]]
	then
  		echo "$2 does not exist...";
	fi
}

push_metadata_file() {
	local path=$1"/metadata/"$2 
	echo $path
	local res=$( (force push -f $path) 2>&1 )
	echo "Result "$res
	#/Users/dcarroll/Documents/Projects/ForceDotCom/VolcomYelpDemo/metadata/staticresources/leaflet.resource
}

push_aura_file() {
	local path=$1"/metadata/aura/"$2 
	echo $path
	local res=$( (force aura push -f $path) 2>&1 )
	echo "Result "$res
	#force aura push -f '/Users/dcarroll/Documents/Projects/ForceDotCom/VolcomYelpDemo/metadata/aura/dataRetrieved/dataRetrieved.evt'
}
force login
#useTempDir
#has_class_file "ApexClass" "YelpDemoControllersss"
cd $curDir
# Add Static resource
push_metadata_file $curDir "staticresources/leaflet.resource"
push_metadata_file $curDir "remoteSiteSettings/YelpApp.remoteSite"
push_metadata_file $curDir "classes/YelpServiceController.cls"
push_metadata_file $curDir "classes/YelpDemoController.cls"
push_aura_file $curDir "dataRetrieved/dataRetrieved.evt"
push_aura_file $curDir "Storage/Storage.cmp"
push_aura_file $curDir "YelpService/YelpService.cmp"
push_aura_file $curDir "YelpService/YelpServiceController.js"
push_aura_file $curDir "YelpService/YelpServiceHelper.js"
push_aura_file $curDir "YelpDemo/YelpDemo.cmp"
push_aura_file $curDir "YelpDemo/YelpDemo.design"
push_aura_file $curDir "YelpDemo/YelpDemo.svg"
push_aura_file $curDir "YelpDemo/YelpDemoController.js"
push_aura_file $curDir "YelpDemo/YelpDemoHelper.js"
push_aura_file $curDir "YelpDemo/YelpDemoRenderer.js"
push_aura_file $curDir "YelpDemo/YelpDemoStyle.css"

echo "END"



