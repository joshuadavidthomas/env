#!/bin/sh

PYENV_INSTALL_DIR=$HOME/.pyenv

install_python_build_deps () {
  echo "${GREEN}** Installing Python build dependencies${RESET}"
  sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

check_for_previous_installation() {
  echo "${BLUE}** Checking for previous pyenv installation${RESET}"
  if [ -d $PYENV_INSTALL_DIR ]; then
    echo "${RED}** Previous installation found${RESET}"
    rm -rf $PYENV_INSTALL_DIR
    echo "${RED}** Previous installation removed${RESET}"
  else
    echo "${GREEN}** No previous installation found${RESET}"
  fi
}

install_pyenv() {
  echo "${GREEN}** Installing pyenv to ${PYENV_INSTALL_DIR}${RESET}"
  git clone https://github.com/pyenv/pyenv.git $PYENV_INSTALL_DIR
}

main() {
  install_python_build_deps
  check_for_previous_installation
  install_pyenv
}

main "$@"
