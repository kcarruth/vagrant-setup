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

# quick-verify that instance appears set up
if [[ ! -d /lv1/collab/bin ]]; then
  echo "Hmm. Looks like vagrant setup didn't complete."
  exit
fi

# back up default vimrc
if [[ -f $VAGRANT_HOME/.vimrc && ! -f $VAGRANT_HOME/.vimrc.orig ]]; then
  mv $VAGRANT_HOME/.vimrc $VAGRANT_HOME/.vimrc.orig
fi

# shell specific stuff
if [[ "$SHELL" == "/usr/bin/zsh" ]]; then
  #
  # vi opts
  #
  if [[ -f $VAGRANT_HOME/.vimrc ]]; then
    rm $VAGRANT_HOME/.vimrc
  fi
  ln -s $SETUP_DIR/assets/vagrant_home/vimrc.zsh $VAGRANT_HOME/.vimrc

  #
  # zsh opts
  #
  if [[ ! -f $VAGRANT_HOME/.zshrc.orig ]]; then
    # back up original
    cp $VAGRANT_HOME/.zshrc $VAGRANT_HOME/.zshrc.orig
  fi

  # replace theme
  sed -i "s/^ZSH_THEME=.*$/ZSH_THEME=mrtazz/" $VAGRANT_HOME/.zshrc

  # set dir colors
  if [[ ! $( grep "NOREPEAT" $VAGRANT_HOME/.zshrc ) ]]; then
    cat $SETUP_DIR/assets/vagrant_home/zshrc.opts | sed "s|#SETUPDIR#|$SETUP_DIR|g" >> $VAGRANT_HOME/.zshrc
  fi
else
  ln -s $SETUP_DIR/assets/vagrant_home/vimrc.bash $VAGRANT_HOME/.vimrc
fi  

# mysql
if [[ ! -f $VAGRANT_HOME/.my.cnf ]]; then
	cp /vagrant/env_resources/_my.cnf $VAGRANT_HOME/.my.cnf
fi 

# grep wrapper
for a in $( ls $SETUP_DIR/assets/collab_bin ); do
  if [[ ! -e $COLLAB_HOME/bin/$a ]]; then
    ln -s $SETUP_DIR/assets/collab_bin/$a $COLLAB_HOME/bin/$a
  fi
done

#cmdir="/usr/local/sakai/content/cm/current-data/support"
#if [[ ! -d $cmdir ]]; then
#	mkdir -p $cmdir; svn co svn+ssh://atgsvn.itc.virginia.edu/sakai/data/cm/support $cmdir
#fi

