#!/bin/bash

POETRY_INSTALL_URL=https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py

check_for_previous_installation() {
  echo "${BLUE}** Checking for previous Poetry installation${RESET}"
  if [ $(command -v poetry) ]; then
    echo "${RED}** Previous installation found${RESET}"
    if [ $(command -v pipx) ]; then
      pipx uninstall poetry
    else
      curl -sSL $POETRY_INSTALL_URL | python - --uninstall
    fi
    echo "${RED}** Previous installation removed${RESET}"
  else
    echo "${GREEN}** No previous installation found${RESET}"
  fi
}

install_poetry() {
  echo "${GREEN}** Installing Poetry${RESET}"
  if [ $(command -v pipx) ]; then
    pipx install poetry
  else
    curl -sSL $POETRY_INSTALL_URL | python -
  fi
}

main() {
  check_for_previous_installation
  install_poetry
}

main "$@"