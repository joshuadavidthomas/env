#!/bin/bash

DOTFILES_DIR=$DIR/dotfiles

for dotfile in $(find ${DOTFILES_DIR} -type f)
do
  dest=$HOME/$(basename $dotfile)
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h $dest ]; then
    echo "${RED}** Removing existing symlink: ${dest}${RESET}"
    rm $dest
  elif [ -f $dest ]; then
    echo "${BLUE}** Backing up existing file: ${dest}${RESET}"
    mv $dest{,.$dateStr}
  fi

  echo "${GREEN}** Creating new symlink: ${dest}${RESET}"
  ln -s $dotfile $dest
done