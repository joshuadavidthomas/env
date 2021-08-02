#!/bin/bash

function add_elixir_repo() {
  echo "${GREEN}** Adding Erlang Solutions repository${RESET}"
  wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
  sudo apt-get update
}

function install_erlang() {
  echo "${GREEN}** Installing Erlang${RESET}"
  sudo apt-get install -y esl-erlang
}

function install_elixir() {
  echo "${GREEN}** Installing Elixir${RESET}"
  sudo apt-get install -y elixir
}

function install_inotify() {
  echo "${GREEN}** Installing inotify-tools${RESET}"
  sudo apt-get install -y inotify-tools
}

function main() {
  add_elixir_repo
  install_erlang
  install_elixir
  install_inotify
}

main "$@"
