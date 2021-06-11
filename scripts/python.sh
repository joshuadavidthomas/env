#!/bin/sh

PYENV_INSTALL_DIR=$HOME/.pyenv

install_python() {
  if [ ! -d "$PYENV_INSTALL_DIR/versions" ]; then
    for version in "$@"; do
      echo "${GREEN}** Installing Python v${version}${RESET}"
      pyenv install ${version}
    done
  fi
}

set_global_python() {
  echo "${GREEN}** Setting global Python version to ${1}${RESET}"
  pyenv global ${1}
}

upgrade_pip() {
  echo "${GREEN}** Upgrading pip to newest version${RESET}"
  python -m pip install --upgrade pip
}

main() {
  install_python 3.8.10
  set_global_python 3.8.10
  upgrade_pip
}

main "$@"