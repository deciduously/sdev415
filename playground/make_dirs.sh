#!/bin/bash

function mkdirs {
	for ((i=1;i<=$1;i++))
	do
		mkdir -p ./week$i/
		cd week$i
		mkdir assignment
		cd -
	done
}

mkdirs 15
