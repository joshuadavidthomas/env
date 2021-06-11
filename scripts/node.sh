#!/bin/bash

NVM_INSTALL_DIR=$HOME/.nvm

function install_node() {
  for version in "$@"; do
    echo "${GREEN}** Installing Node ${version}${RESET}"
    nvm install ${version}
  done
}

function update_npm() {
  echo "${GREEN}** Updating NPM to the latest version${RESET}"
  npm install -g npm
  echo "${GREEN}** Setting cafile config${RESET}"
  npm config set cafile $HOME/.certs/cacert.pem
}

function install_yarn() {
  echo "${GREEN}** Installing Yarn${RESET}"
  npm install -g yarn
  echo "${GREEN}** Setting cafile config${RESET}"
  yarn config set cafile $HOME/.certs/cacert.pem
}

function main() {
  install_node --lts
  update_npm
  install_yarn
}

main "$@"