#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset
set -o errtrace


function notify {
  echo "Something went wrong!"
  echo "$(caller): ${BASH_COMMAND}"
}

trap notify ERR


DIR="$(dirname "$0")"
URL=https://raw.githubusercontent.com/joshuadavidthomas/env/main
RESET=$(printf '\033[m')
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
GRAY=$(printf '\033[37m')
BOLD=$(printf '\033[1m')


function step() {
  if [ -v STEP_ONE ]; then
    echo ""
  fi
  printf "$BOLD$YELLOW********* $1 $RESET\n"
  echo ""
  STEP_ONE="complete"
}

function start() {
  clear
  printf "Caching password... \n\n"
  sudo -K
  sudo true;
  clear
}

##### certs
function install_ca_certificates() {
  echo "${GREEN}** Installing ca-certificates package${RESET}"
  sudo apt-get install ca-certificates -y
}

function copy_certs () {
  echo "${GREEN}** Copying TWC certs to ${HOME}/.certs"
  mkdir -p ${HOME}/.certs
  cp -r ${URL}/certs ${HOME}/.certs
  echo "${GREEN}** Copying twcssc.pem to /usr/local/share/ca-certificates/twcssc.crt${RESET}"
  sudo cp ${URL}/certs/twcssc.pem /usr/local/share/ca-certificates/twcssc.crt
}

function update_ca_certificates() {
  echo "${GREEN}** Running update-ca-certificates command${RESET}"
  sudo update-ca-certificates
}

function certs() {
  install_ca_certificates
  copy_certs
  update_ca_certificates
}

##### common

function restart_shell() {
  echo "${GREEN}** Restarting shell${RESET}"
  exec $SHELL
}

function main() {
  start

  step 'certs'
  certs

  step 'common'
  source ${DIR}/scripts/common.sh

  step 'zsh'
  source ${DIR}/scripts/zsh.sh

  step 'ohmyzsh'
  source ${DIR}/scripts/ohmyzsh.sh

  step 'dotfiles'
  source ${DIR}/scripts/dotfiles.sh

  step 'pyenv'
  source ${DIR}/scripts/pyenv.sh

  step 'python'
  source ${DIR}/scripts/python.sh

  step 'pipx'
  source ${DIR}/scripts/pipx.sh

  step 'poetry'
  source ${DIR}/scripts/poetry.sh

  step 'nvm'
  source ${DIR}/scripts/nvm.sh

  step 'node'
  source ${DIR}/scripts/node.sh

  step 'cleanup'
  restart_shell
}

main "$@"