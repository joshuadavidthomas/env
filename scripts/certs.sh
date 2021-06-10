#!/bin/bash

function install_ca_certificates() {
  echo "${GREEN}** Installing ca-certificates package${RESET}"
  sudo apt-get install ca-certificates -y
}

function copy_certs () {
  echo "${GREEN}** Copying TWC certs to ${HOME}/.certs"
  mkdir -p ${HOME}/.certs
  cp -r ${DIR}/certs ${HOME}/.certs
  echo "${GREEN}** Copying twcssc.pem to /usr/local/share/ca-certificates/twcssc.crt${RESET}"
  sudo cp ${DIR}/certs/twcssc.pem /usr/local/share/ca-certificates/twcssc.crt
}

function update_ca_certificates() {
  echo "${GREEN}** Running update-ca-certificates command${RESET}"
  sudo update-ca-certificates
}

function main() {
  install_ca_certificates
  copy_certs
  update_ca_certificates
}

main "$@"
