#!/bin/sh

check_for_previous_installation() {
  echo "${BLUE}** Checking for previous pipx installation${RESET}"
  if [ $(command -v pipx) ]; then
    echo "${RED}** Previous installation found${RESET}"
    python -m pip uninstall -y pipx
    echo "${RED}** Previous installation removed${RESET}"
  else
    echo "${GREEN}** No previous installation found${RESET}"
  fi
}

install_pipx() {
  echo "${GREEN}** Installing pipx${RESET}"
  python -m pip install --user pipx
  python -m pipx ensurepath
}

main() {
  check_for_previous_installation
  install_pipx
}

main "$@"