#!/bin/bash

# this script should be run to set up the directory structure
# right after cloning the repo

# default bindir. can be set with -b
bindir="$HOME/bin"

# this function checks the PATH to make sure it contains
# the $bindir or not
path_check() {
	if [[ ! ":$PATH:" == *":$bindir:"* ]]; then
		printf "%s\n" "adding $bindir to PATH..."
		printf "export PATH=$PATH:$bindir\n" >> ~/.profile
	else
		printf "%s\n" "$bindir already exists in PATH"
	fi
}

install() {
	mkdir -p $bindir

	printf "%s\n" "installing scripts..."
	cp install/* $bindir
}

usage() {
	printf "%s\n" "Usage: ./setup.sh [OPTIONS]"
	printf "%s\n" "Examples: ./setup.sh -b $HOME/bin"
	printf "%s\n" "          ./setup.sh"
	printf "%s\n" "Options:"
	printf "%s\n" "-b '/path/to/bin/dir'  Directory scripts should be installed to. Default is '$HOME/bin'."
	printf "%s\n" "-h                     Print this help."
}

get_args() {
	while getopts ":b:h" opt; do
		case $opt in
			b)
				bindir=$OPTARG
				printf "%s\n" "install location: $OPTARG" >&2
				;;
			h)
				usage
				exit 0
				;;
			\?)
				printf "%s\n" "Invalid option: -$OPTARG. Run with '-h' for help"
				exit 1
				;;
			:)
				printf "%s\n" "-$OPTARG must be run with a directory name. Run with '-h' for help"
				exit 1
				;;
		esac
	done
}

main() {
	get_args "$@"
	path_check

	# we've gotten this far, go ahead and copy scripts
	install
	#source ~/.profile
	printf "done.\n"
}

main "$@"
