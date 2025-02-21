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

echo "Installation complete. Reboot recommended."


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

echo "Installation complete! ✅"

