#!/bin/bash

BASEDIR=`dirname $0`
FILES=".vim .vimrc.local .gvimrc.local .vimrc .inputrc .bash .gitconfig"

for F in $FILES; do
  if [ -e ~/$F ]; then
    mv ~/$F{,.old}
    echo "moved existing $F to $F.old"
  fi

  ln -s $BASEDIR/dotfiles/dot.$F ~/$F
done

if [ -e ~/bin ]; then
  mv ~/$f{,.old}
fi

ln -s $BASEDIR/bin ~/bin

cat $BASEDIR/dotfiles/dot.bash_login >> ~/.bash_login
cat $BASEDIR/dotfiles/dot.bash_login >> ~/.bashrc
cat $BASEDIR/dotfiles/dot.bash_login >> ~/.profile
