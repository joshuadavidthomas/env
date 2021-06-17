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


INSTALL_DIR=$HOME/.env

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

function restart_shell() {
  echo "${GREEN}** Restarting shell${RESET}"
  exec $SHELL
}

function start() {
  clear
  step 'pregame'
  echo "${BLUE}** Checking for previous installation${RESET}"
  if [ -d $INSTALL_DIR ]; then
    echo "${RED}** Previous installation found${RESET}"
    source ${INSTALL_DIR}/scripts/upgrade.sh
  else
    echo "${GREEN}** No previous installation found${RESET}"
    echo "${GREEN}** Installing to ${INSTALL_DIR}${RESET}"
    git clone https://github.com/joshuadavidthomas/env.git $INSTALL_DIR
  fi
  step 'password'
  printf "Caching password... \n\n"
  sudo -K
  sudo true
}

function end() {
  step 'postgame'
  restart_shell
  exit
}

function main() {
  start

  step 'certs'
  source ${INSTALL_DIR}/scripts/certs.sh

  step 'zsh'
  source ${INSTALL_DIR}/scripts/zsh.sh

  step 'ohmyzsh'
  source ${INSTALL_DIR}/scripts/ohmyzsh.sh

  step 'dotfiles'
  source ${INSTALL_DIR}/scripts/dotfiles.sh

  step 'packages'
  source ${INSTALL_DIR}/scripts/packages.sh

  step 'pyenv'
  source ${INSTALL_DIR}/scripts/pyenv.sh

  step 'python'
  source ${INSTALL_DIR}/scripts/python.sh

  step 'pipx'
  source ${INSTALL_DIR}/scripts/pipx.sh

  step 'poetry'
  source ${INSTALL_DIR}/scripts/poetry.sh

  step 'nvm'
  source ${INSTALL_DIR}/scripts/nvm.sh

  step 'node'
  source ${INSTALL_DIR}/scripts/node.sh

  end
}

main "$@"
