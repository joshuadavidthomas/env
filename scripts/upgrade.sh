#!/bin/bash
# Lifted shamelessly from Oh My Zsh's upgrade script
# https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/upgrade.sh

cd "$INSTALL_DIR"

LAST_COMMIT=$(git rev-parse HEAD)

function update() {
  printf "${GREEN}%s${RESET}\n" "** Updating local dev environment"
  if git pull --rebase --stat origin main; then
    # Check if it was really updated or not
    if [[ "$(git rev-parse HEAD)" = "$LAST_COMMIT" ]]; then
      message="** Local dev environment is already at the latest version."
    else
      message="** Hooray! Local dev environment has been updated!"
      git config devEnv.lastVersion "$LAST_COMMIT"
    fi
    printf "${GREEN}%s${RESET}\n" "$message"
  else
    printf "${RED}%s${RESET}\n" '** There was an error updating. Try again later?'
    exit $?
  fi
}

main() {
  update
}

main "$@"
