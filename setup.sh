#!/bin/bash

echo "Updating package list..."
sudo apt update -y && sudo apt upgrade -y

echo "Adding Kali repositories..."
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list.d/kali.list

echo "Adding Kali Linux signing key..."
wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -

echo "Updating package list again..."
sudo apt update -y

echo "Installing Kali tools..."
sudo apt install -y kali-linux-default kali-linux-top10 kali-linux-everything

echo "Updating package list..."
sudo apt update -y && sudo apt upgrade -y

# Install Python & Pip
echo "Installing Python & Pip..."
sudo apt install -y python3 python3-pip

# Install PHP & Composer
echo "Installing PHP & Composer..."
sudo apt install -y php-cli php-mbstring php-xml php-curl php-zip php-bcmath php-tokenizer unzip curl
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install Java (OpenJDK 17)
echo "Installing Java..."
sudo apt install -y openjdk-17-jdk

# Install Node.js & npm (Latest LTS)
echo "Installing Node.js & npm..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Install C++ (GCC/G++)
echo "Installing C++ (GCC/G++)..."
sudo apt install -y build-essential g++

# Install PyQt
echo "Installing PyQt..."
sudo apt install -y python3-pyqt5 qttools5-dev-tools

# Install Laravel
echo "Installing Laravel..."
composer global require laravel/installer
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

## Docker

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
sudo systemctl start docker
sudo systemctl enable docker
sudo docker --version

sudo apt update

# Install dependencies for Google Chrome
sudo apt install -y wget curl gnupg2

# Add Google Chrome repository and key
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

# Install Google Chrome
sudo apt update
sudo apt install -y google-chrome-stable

# Install dependencies for VS Code
sudo apt install -y software-properties-common apt-transport-https

# Add Microsoft GPG key and repository for VS Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

# Install VS Code
sudo apt update
sudo apt install -y code

# Confirm installations
echo "Google Chrome and Visual Studio Code have been installed."
google-chrome --version
code --version

sudo apt update
# Install neofetch
sudo apt install -y neofetch

# Add neofetch to the terminal startup by editing the .bashrc file
echo "neofetch" >> ~/.bashrc

# Notify user of successful installation
echo "Neofetch has been installed and set to run on terminal startup."

# Download the image
wget -O /tmp/temp_wallpaper.png "https://i.redd.it/g8ud4yocwbeb1.png"

# Set the wallpaper using `gsettings` (for GNOME or Ubuntu)
gsettings set org.gnome.desktop.background picture-uri "file:///tmp/temp_wallpaper.png"

# Optional: Clean up the downloaded file
rm /tmp/temp_wallpaper.png

echo "Installation complete! ✅"

