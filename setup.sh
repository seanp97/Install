#!/bin/bash

set -e  # Exit immediately if any command exits with a non-zero status.

# Function to update and upgrade the system
update_system() {
    echo "Updating package list and upgrading packages..."
    sudo apt update -y && sudo apt upgrade -y
}

# Function to add a repository and install packages
install_packages() {
    echo "Installing packages: $1..."
    sudo apt install -y $1
}

# Function to add a repository and key
add_repository() {
    echo "Adding repository: $1..."
    echo "$2" | sudo tee /etc/apt/sources.list.d/$1.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $3
}

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y docker-ce
    sudo systemctl start docker
    sudo systemctl enable docker
}

# Function to install Google Chrome
install_chrome() {
    echo "Installing Google Chrome..."
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    sudo apt update
    sudo apt install -y google-chrome-stable
}

# Function to install VS Code
install_vscode() {
    echo "Installing Visual Studio Code..."
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install -y code
}

# Function to install Neofetch
install_neofetch() {
    echo "Installing Neofetch..."
    sudo apt install -y neofetch
    echo "neofetch" >> ~/.bashrc
    echo "Neofetch has been installed and set to run on terminal startup."
}

# Function to set wallpaper
set_wallpaper() {
    echo "Setting wallpaper..."
    wget -O /tmp/temp_wallpaper.png "https://i.redd.it/g8ud4yocwbeb1.png"
    gsettings set org.gnome.desktop.background picture-uri "file:///tmp/temp_wallpaper.png"
    rm /tmp/temp_wallpaper.png
}

# Main Installation Steps
update_system
add_repository "kali" "deb http://http.kali.org/kali kali-rolling main non-free contrib" "74B6B1C3B4A2B5E9"
install_packages "kali-linux-default kali-linux-top10 kali-linux-everything"
install_packages "python3 python3-pip"
install_packages "php-cli php-mbstring php-xml php-curl php-zip php-bcmath php-tokenizer unzip curl"
install_packages "openjdk-17-jdk"
install_packages "build-essential g++"
install_packages "python3-pyqt5 qttools5-dev-tools"
install_packages "wget curl gnupg2 software-properties-common apt-transport-https"

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

install_docker
install_chrome
install_vscode
install_neofetch
set_wallpaper

echo "Installation complete! ✅"
