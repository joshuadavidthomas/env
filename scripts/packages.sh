#!/bin/bash

PACKAGES='ripgrep'

function update() {
  sudo apt-get update
}

function install_packages() {
  sudo apt-get install $PACKAGES -y
}

main() {
  update
  install_packages
}

main "$@"
