#!/bin/bash

# TODO: install carlhuda automatically
# https://github.com/carlhuda/janus.git


# Files to move
FILES=".vimrc.local .gvimrc.local .inputrc .bash .gitconfig"

# Convert relative -> absolute path
function absolute_path() {
  local PARENT_DIR=$(dirname "$1")
  cd "$PARENT_DIR"
  local ABS_PATH="$(pwd)"/"$(basename $1)"
  cd - > /dev/null

  echo $ABS_PATH
}

# Path to this script
BASEDIR=`dirname $0`

# If .vim doesn't exist, install Janus
if [ ! -e ~/.vim ]; then
  echo "Installing Janus Vim Distribution"
  curl -Lo- http://bit.ly/janus-bootstrap | bash
  echo "done."
  echo
fi

# Link all config files, save as $F.old if already found
for F in $FILES; do
  if [ -e ~/$F ]; then
    mv ~/$F{,.old}
    echo "moved existing $F to $F.old"
  fi

  ln -s $(absolute_path $BASEDIR/dotfiles/dot$F) ~/$F
done

# Link bin directory
test -e ~/bin && mv ~/bin{,.old}
ln -s $(absolute_path $BASEDIR/bin) ~/bin

# Add loading routine to ~/.bash_profile UNLESS already added
touch ~/.bash_profile
if [ ! "$(grep 'Load all scripts in ~/.bash' ~/.bash_profile)" ]; then

  cat >> ~/.bash_profile <<"EOF"

# Load all scripts in ~/.bash
EXTRADIR=~/.bash
if [ -d "$EXTRADIR" ]; then
  for F in `find $EXTRADIR/ -type f | xargs`; do
    if [ "$(basename $F)" != "local" ]; then
      source $F
    fi
  done

  # Load .bash/local last to make sure it overrides all others
  test -e "$EXTRADIR/local" && source "$EXTRADIR/local"
fi

EOF

fi
