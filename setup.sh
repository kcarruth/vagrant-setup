#!/bin/bash

if [[ $( whoami ) != "vagrant" ]]; then
	echo "error: you need to be vagrant user"
	exit
fi


git config --global user.name "Kevin Carruth"
git config --global user.email "kcarruth@virginia.edu"

VAGRANT_HOME="/home/vagrant"
COLLAB_HOME="/lv1/collab"
SETUP_DIR="/vagrant/kevin/setup"

# back up default vimrc
if [[ -f $VAGRANT_HOME/.vimrc ]]; then
  mv $VAGRANT_HOME/.vimrc $VAGRANT_HOME/.vimrc.bkup
fi

# shell specific stuff
if [[ "$SHELL" == "/usr/bin/zsh" ]]; then
  #
  # vi opts
  #
  ln -s $SETUP_DIR/vimrc.zsh $VAGRANT_HOME/.vimrc

  #
  # zsh opts
  #
  cp $VAGRANT_HOME/.zshrc $VAGRANT_HOME/.zshrc.old

  # theme
  sed -i "s/^ZSH_THEME=.*$/ZSH_THEME=mrtazz/" $VAGRANT_HOME/.zshrc

  # set dir colors
  cat $SETUP_DIR/zshrc.opts | sed "s|#SETUPDIR#|$SETUP_DIR|g" >> $VAGRANT_HOME/.zshrc
else
  ln -s $SETUP_DIR/vimrc.bash $VAGRANT_HOME/.vimrc
fi  

# mysql
if [[ ! -f $VAGRANT_HOME/.my.cnf ]]; then
	cp /vagrant/env_resources/_my.cnf $VAGRANT_HOME/.my.cnf
fi 

# grep wrapper
if [[ ! -e $COLLAB_HOME/bin/kgrep ]]; then
	ln -s $SETUP_DIR/kgrep $COLLAB_HOME/bin/kgrep
fi

#cmdir="/usr/local/sakai/content/cm/current-data/support"
#if [[ ! -d $cmdir ]]; then
#	mkdir -p $cmdir; svn co svn+ssh://atgsvn.itc.virginia.edu/sakai/data/cm/support $cmdir
#fi

