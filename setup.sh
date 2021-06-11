#!/bin/sh

set -e


DIR="$(dirname "$0")"
RESET=$(printf '\033[m')
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
GRAY=$(printf '\033[37m')
BOLD=$(printf '\033[1m')


step() {
  if [ -v STEP_ONE ]; then
    echo ""
  fi
  printf "$BOLD$YELLOW********* $1 $RESET\n"
  echo ""
  STEP_ONE="complete"
}

start() {
  clear
  printf "Caching password... \n\n"
  sudo -K
  sudo true;
  clear
}

restart_shell() {
  echo "${GREEN}** Restarting shell${RESET}"
  exec $SHELL
}

main() {
  start

  step 'certs'
  source ${DIR}/scripts/certs.sh

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