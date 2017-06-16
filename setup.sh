#!/bin/bash

# this script should be run to set up the directory structure
# right after cloning the repo
bindir="$HOME/bin"

mkdir -p $bindir
cp install/* $bindir

# export PATH variable
if [ -f ~/.profile ]; then
	if [[ ! ":$PATH:" == *":$HOME/bin"* ]]; then
		printf "export PATH=$PATH:$bindir\n" >> ~/.profile
	fi

else
	printf "export PATH=$PATH:$bindir\n" >> ~/.profile
fi

source ~/.profile
