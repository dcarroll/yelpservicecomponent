#!/usr/bin/env bash

describe="$(force describe -t metadata)"
oldIFS=$IFS 
IFS=$'
'

function findMetadataType() {
	oldIFS=$IFS
	IFS=$'
	'
	local mdType=""
	local array=( $describe )
	for i in "${array[@]}";
	do
		folderName=${i#*==> };
		metadataType=${i%==*};
		if [ $1 == $folderName ]
		then
			mdType=$metadataType
			break
		fi
	done
	IFS=$oldIFS
	if [ "$mdType" != "" ]
	then
		echo $mdType
	else
		echo "not found"
	fi
}

function findMetadataObject() {
	result="$(force describe -t metadata -n $1)"
	oldIFS=$IFS
	IFS=$'
	'
	local array=( $result )
	for i in "${array[@]}";
	do
		local objName="${i% -*}"
		if [ "$2" == "$objName" ]
		then
			echo "found"
			break
		fi
	done
	IFS=$oldIFS
}

for j in `cat ../metadata_artifacts.txt`
do 
	mdType=$( findMetadataType "${j%/*}" )
	mdType="$(echo -e "${mdType}" | tr -d '[[:space:]]')"
	mdName="${j%.*}"
	mdName="${mdName##*/}"
	res=$( findMetadataObject "$mdType" "$mdName" )
	if [[ ( "$res" == "found" && $overwrite != "y" ) ]]
	then
		echo "WARNING - Found an existing version of $mdName in your org, overwrite (y/n)?"
		read overwrite
		if [ $overwrite == "n" ]
		then
			echo "Aborting..."
			exit 1
		fi
	fi
done

IFS=$oldIFS
