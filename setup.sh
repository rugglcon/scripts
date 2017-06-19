#!/bin/bash

# this script should be run to set up the directory structure
# right after cloning the repo

# default bindir. can be set with -b
bindir="$HOME/bin"
path_add=1

error_trig() {
	printf "%s\n" "$1" 1>&2
	exit 1
}

path_check() {
	if [[ ! ":$PATH:" == *":$bindir:"* ]]; then
		printf "%s\n" "adding $bindir to PATH..."
		printf "export PATH=$PATH:$bindir\n" >> ~/.profile
		path_add=0
	else
		printf "%s\n" "$bindir already exists in PATH"
	fi
}

install() {
	mkdir -p $bindir

	printf "%s\n" "installing scripts..."
	cp install/* $bindir
	
	if [[ $path_add -eq 0 ]]; then
		source ~/.profile
	fi
}

usage() {
	printf "%s\n" "Usage: ./setup.sh [OPTIONS]"
	printf "%s\n" "Examples: ./setup.sh -b $HOME/bin"
	printf "%s\n" "          ./setup.sh"
	printf "%s\n" "Options:"
	printf "%s\n" "-b '/path/to/bin'  Install dir. Default is '$HOME/bin'."
	printf "%s\n" "-h                 Print this help."
}

get_args() {
	bin_set=0
	while getopts ":b:h" opt; do
		case $opt in
			b)
				if [[ $bin_set -eq 0 ]]; then
					bin_set=1
					bindir=$OPTARG
					printf "%s\n" "install location: $OPTARG"
				else
					error_trig "'-b' provided too many times. Run with '-h' for help"
				fi
				;;
			h)
				usage
				exit 0
				;;
			\?)
				error_trig "Invalid option: $OPTARG. Run with '-h' for help"
				;;
			:)
				error_trig "$OPTARG must be run with a directory name. Run with '-h' for help"
				;;
		esac
	done
}

main() {
	get_args "$@"
	path_check

	# we've gotten this far, go ahead and copy scripts
	install
	
	printf "done.\n"
}

main "$@"
