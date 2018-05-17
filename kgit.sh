#!/bin/bash
#
# wrapper for git

OP="$1"
shift

GHROOT="git@github.com:stacs"

if [[ "$OP" == "clone" || "$OP" == "checkout" ]]; then
	repo=$1
	shift
	git clone $GHROOT/$repo $@
else
	git $OP $@
fi
