#!/bin/bash
#
# compare current working git dir w/ svn checkout of same

ROOTDIR=/home/vagrant/collab11
GITDIR=$ROOTDIR/code
SVNDIR=$ROOTDIR/svn

# get tool being worked on
TOOL=$( pwd | sed "s|.*/||" )

FILE=$1

diff -w $GITDIR/$TOOL/$FILE $SVNDIR/$TOOL/$FILE
