#!/bin/bash

# TODO: install carlhuda automatically
# https://github.com/carlhuda/janus.git

HOMEDIR=~
BASEDIR=`dirname $0`

FILES=".vimrc.local .gvimrc.local .vimrc .inputrc .bash .gitconfig"

function absolute_path() {
  local PARENT_DIR=$(dirname "$1")
  cd "$PARENT_DIR"
  local ABS_PATH="$(pwd)"/"$(basename $1)"
  cd - > /dev/null

  echo $ABS_PATH
}

for F in $FILES; do
  if [ -e $HOMEDIR/$F ]; then
    mv $HOMEDIR/$F{,.old}
    echo "moved existing $F to $F.old"
  fi

  ln -s $(absolute_path $BASEDIR/dotfiles/dot$F) $HOMEDIR/$F
done

if [ -e $HOMEDIR/bin ]; then
  mv $HOMEDIR/bin{,.old}
fi

ln -s $BASEDIR/bin $HOMEDIR/bin

#   
cat $BASEDIR/dotfiles/dot.bash_login >> $HOMEDIR/.bash_profile
