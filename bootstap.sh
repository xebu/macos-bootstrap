#!/usr/bin/env bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/

set -euo pipefail
IFS=$'\n\t'

xcode-select --install

SUDO_USER=$(whoami)

# Check for Homebrew, install if not installed
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update
brew upgrade

# find the CLI Tools update
echo "find CLI tools update"
PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n') || true
# install it
if [[ ! -z "$PROD" ]]; then
  softwareupdate -i "$PROD" --verbose
fi
