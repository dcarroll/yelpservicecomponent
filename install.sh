#!/usr/bin/env bash

status() {
	echo "-----> $*" 
}

push_metadata_file() {
	local path=$PWD"/metadata/"$1 
	local res=$( (force push -f $path) 2>&1 )
	if [[ $res == "ERROR"* ]]
	then
		echo "$res"
	else
  		status "$1 Deployed...";
	fi
	#force push -f /Users/dcarroll/Documents/Projects/ForceDotCom/VolcomYelpDemo/metadata/staticresources/leaflet.resource
}

push_aura_file() {
	local path=$PWD"/metadata/aura/"$1
	local res=$( (force aura push -f $path) 2>&1 )
	#local res=$(force aura push -f $path)
	if [[ $res == "ERROR"* ]]
	then
  		status "$res"
  	else
  		status "$1 Deployed...";
	fi
	#force aura push -f '/Users/dcarroll/Documents/Projects/ForceDotCom/VolcomYelpDemo/metadata/aura/dataRetrieved/dataRetrieved.evt'
}

force login

#	IFS=$'\n'       # make newlines the only separator
for j in `cat ./metadata_artifacts.txt`
do
	push_metadata_file "$j"
done

for j in `cat ./lightning_artifacts.txt`
do
	push_aura_file "$j"
done

cd ..
mv yelpservicedemo/ ../
cd ..

[ "$(ls -A node_modules)" ] && echo $'\nnode_modules not empty, leaving in place...' || rm -r node_modules

echo "END"



