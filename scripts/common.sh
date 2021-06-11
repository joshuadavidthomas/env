#!/bin/bash

function install_packages() {
  echo "${GREEN}** Installing common packages${RESET}"
  sudo apt-get install -y $* || true;
  sudo dpkg --configure -a || true;
  sudo apt-get autoclean && sudo apt-get clean;
}

function main() {
  install_packages git curl
}

main "$@"