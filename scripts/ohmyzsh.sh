#!/bin/sh

ZSH=${ZSH:-~/.oh-my-zsh}
REPO=${REPO:-ohmyzsh/ohmyzsh}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-master}
SPACESHIP_DIR=$ZSH/custom/themes/spaceship-prompt

install_oh_my_zsh() {
  echo "${BLUE}** Checking for previous Oh My Zsh installation${RESET}"
  if [ -d $ZSH ]; then
    echo "${RED}** Previous installation found${RESET}"
    rm -rf $ZSH
    echo "${RED}** Previous installation removed${RESET}"
  else
    echo "${GREEN}** No previous installation found${RESET}"
  fi
  echo "${GREEN}** Installing Oh My Zsh${RESET}"
  umask g-w,o-w
  git clone -c core.eol=lf -c core.autocrlf=false \
    -c fsck.zeroPaddedFilemode=ignore \
    -c fetch.fsck.zeroPaddedFilemode=ignore \
    -c receive.fsck.zeroPaddedFilemode=ignore \
    --depth=1 --branch "$BRANCH" "$REMOTE" "$ZSH"
}

install_spaceship_prompt() {
  echo "${BLUE}** Checking for previous Spaceship ZSH Prompt installation${RESET}"
  if [ -d $SPACESHIP_DIR ]; then
    echo "${RED}** Previous installation found${RESET}"
    rm -rf $SPACESHIP_DIR
    echo "${RED}** Previous installation removed${RESET}"
  else
    echo "${GREEN}** No previous installation found${RESET}"
  fi
  echo "${GREEN}** Installing Spaceship ZSH Prompt${RESET}"
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git $SPACESHIP_DIR --depth=1
  ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/custom/themes/spaceship.zsh-theme"
}

main() {
  install_oh_my_zsh
  install_spaceship_prompt
}

main "$@"