#!/bin/bash

# Fresh ubuntu 22.04 install deps.

install_chrome () {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
}

install_vscode () {
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install -y apt-transport-https
    sudo apt update
    sudo apt install -y code # or code-insiders
}

# TODO(chris@)
install_stremio () {
    wget https://dl.strem.io/shell-linux/v4.4.159/stremio_4.4.159-1_amd64.deb
}

install_spotify () {
    sudo apt install -y curl
    curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install -y spotify-client
}

install_utils () {
    sudo add-apt-repository universe
    sudo apt install -y hardinfo bashtop gnome-tweaks 
    # FIXME(chris@):
    # sudo apt install -y gnome-shell-extensions gnome-shell-extension-system-monitor
}

install_git () {
  sudo apt install -y git
  git config --global user.email "chris@virtanatech.com"
  git config --global user.name "Christopher Sahadeo"
}

# Main.
cd /tmp
sudo apt update
# install_chrome
# install_vscode
# install_stremio
# install_spotify
install_utils
# install_git
