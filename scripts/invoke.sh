#!/bin/bash

check_for_previous_installation() {
  echo "${BLUE}** Checking for previous Invoke installation${RESET}"
  if [ $(command -v invoke) ]; then
    echo "${RED}** Previous installation found${RESET}"
    if [ $(command -v pipx) ]; then
      pipx uninstall invoke
    else
      pip uninstall invoke
    fi
    echo "${RED}** Previous installation removed${RESET}"
  else
    echo "${GREEN}** No previous installation found${RESET}"
  fi
}

install_invoke() {
  echo "${GREEN}** Installing Invoke${RESET}"
  if [ $(command -v pipx) ]; then
    pipx install invoke
  else
    pip install invoke
  fi
}

main() {
  check_for_previous_installation
  install_invoke
}

main "$@"
