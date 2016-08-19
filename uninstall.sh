#!/usr/bin/env bash

status() {
	echo "-----> $*" 
}

delete_aura_file() {
	local path=$PWD"/metadata/aura/"$1
	echo $path
	local res=$( (force aura delete -p $path) &>/dev/null )
	if [[ $res != "ERROR"* ]]
	then
  		status "$1 deleted...";
	fi
	#force aura push -f '/Users/dcarroll/Documents/Projects/ForceDotCom/VolcomYelpDemo/metadata/aura/dataRetrieved/dataRetrieved.evt'
}

force login

IFS=$'\n'       # make newlines the only separator
for j in `cat ./lightning_removal_artifacts.txt`
do
	delete_aura_file "$j"
done


[ "$(ls -A node_modules)" ] && echo $'\nnode_modules not empty, leaving in place...' || rm -rf node_modules

echo "END"



