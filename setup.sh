#!/bin/bash

# this script should be run to set up the directory structure
# right after cloning the repo
bindir="$HOME/bin"

mkdir -p $bindir
cp install/* $bindir
