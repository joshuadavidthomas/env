#!/bin/sh

NVM_INSTALL_DIR=$HOME/.nvm

check_for_previous_installation() {
  echo "${BLUE}** Checking for previous nvm installation${RESET}"
  if [ -d $NVM_INSTALL_DIR  ]; then
    echo "${RED}** Previous installation found${RESET}"
    rm -rf $NVM_INSTALL_DIR
    echo "${RED}** Previous installation removed${RESET}"
  else
    echo "${GREEN}** No previous installation found${RESET}"
  fi
}

install_nvm() {
  echo "${GREEN}** Installing nvm to ${NVM_INSTALL_DIR}${RESET}"
  git clone https://github.com/nvm-sh/nvm.git $NVM_INSTALL_DIR
  (cd $NVM_INSTALL_DIR; git checkout v0.38.0)
  source $NVM_INSTALL_DIR/nvm.sh
}

main() {
  check_for_previous_installation
  install_nvm
}

main "$@"