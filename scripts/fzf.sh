#!/bin/bash

FZF_INSTALL_DIR=$HOME/.fzf

function check_for_previous_installation() {
  echo "${BLUE}** Checking for previous fzf installation${RESET}"
  if [ -d $FZF_INSTALL_DIR  ]; then
    echo "${RED}** Previous installation found${RESET}"
    rm -rf $FZF_INSTALL_DIR
    echo "${RED}** Previous installation removed${RESET}"
  else
    echo "${GREEN}** No previous installation found${RESET}"
  fi
}

function install_fzf() {
  echo "${GREEN}** Installing fzf to ${FZF_INSTALL_DIR}${RESET}"
  git clone --depth 1 https://github.com/junegunn/fzf.git $FZF_INSTALL_DIR
  source $FZF_INSTALL_DIR/install
}

function main() {
  check_for_previous_installation
  install_fzf
}

main "$@"