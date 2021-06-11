#!/bin/sh

install_zsh() {
  echo "${GREEN}** Installing zsh shell${RESET}"
  sudo apt-get install zsh
}

set_default_shell() {
  echo "${GREEN}** Setting zsh as default shell${RESET}"
  sudo chsh -s /bin/zsh $USER
}

main() {
  install_zsh
  set_default_shell
}

main "$@"