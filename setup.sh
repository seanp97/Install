#!/bin/bash

set -e  # Exit immediately if any command exits with a non-zero status.

# Function to update and upgrade the system
update_system() {
    echo "Updating package list and upgrading packages..."
    sudo apt update -y && sudo apt upgrade -y || echo "Update/Upgrade failed, continuing..."
}

# Function to install packages
install_packages() {
    echo "Installing packages: $1..."
    sudo apt install -y $1 || echo "Failed to install $1, continuing..."
}

# Function to add a repository and key securely
add_repository() {
    echo "Adding repository: $1..."
    echo "$2" | sudo tee /etc/apt/sources.list.d/$1.list
    curl -fsSL "$3" | sudo tee /usr/share/keyrings/$1-archive-keyring.gpg > /dev/null
}

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common || echo "Failed to install dependencies for Docker, continuing..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /usr/share/keyrings/docker-archive-keyring.gpg > /dev/null
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce || echo "Failed to install Docker, continuing..."
    sudo systemctl start docker
    sudo systemctl enable docker
}

# Function to install Google Chrome
install_chrome() {
    echo "Installing Google Chrome..."
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome-keyring.gpg > /dev/null
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
    sudo apt update
    sudo apt install -y google-chrome-stable || echo "Failed to install Chrome, continuing..."
}

# Function to install VS Code
install_vscode() {
    echo "Installing Visual Studio Code..."
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-keyring.gpg > /dev/null
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    sudo apt update
    sudo apt install -y code || echo "Failed to install VS Code, continuing..."
}

# Function to install Notion desktop
install_notion() {
    echo "Installing Notion desktop..."
    wget -qO- https://notion.davidbailey.codes/notion-linux.list | sudo tee /etc/apt/sources.list.d/notion-linux.list
    wget -qO- https://notion.davidbailey.codes/notion.asc | gpg --dearmor | sudo tee /usr/share/keyrings/notion-keyring.gpg > /dev/null
    sudo apt update
    sudo apt install -y notion-app-enhanced || echo "Failed to install Notion, continuing..."
}

# Function to install Spotify
install_spotify() {
    echo "Installing Spotify..."
    curl -sS https://download.spotify.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/spotify-keyring.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/spotify-keyring.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null
    sudo apt update
    sudo apt install -y spotify-client || echo "Failed to install Spotify, continuing..."
}

# Function to set wallpaper
set_wallpaper() {
    echo "Setting wallpaper..."
    wget -O /tmp/temp_wallpaper.png "https://images.unsplash.com/photo-1511300636408-a63a89df3482?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGludXglMjB3YWxscGFwZXJ8ZW58MHx8MHx8fDA%3D" || echo "Failed to download wallpaper, continuing..."
    gsettings set org.gnome.desktop.background picture-uri "file:///tmp/temp_wallpaper.png" || echo "Failed to set wallpaper, continuing..."
    rm /tmp/temp_wallpaper.png
}

# Main Installation Steps
update_system
add_repository "kali" "deb http://http.kali.org/kali kali-rolling main non-free contrib" "https://archive.kali.org/archive-key.asc"
install_packages "kali-linux-defaults kali-desktop-core kali-linux-everything"
install_packages "python3 python3-pip"
install_packages "php-cli php-mbstring php-xml php-curl php-zip php-bcmath php-tokenizer unzip curl"
install_packages "openjdk-17-jdk"
install_packages "build-essential g++"
install_packages "python3-pyqt5 qttools5-dev-tools"
install_packages "wget curl gnupg2 software-properties-common apt-transport-https"

curl -sS https://getcomposer.org/installer | php || echo "Failed to install Composer, continuing..."
sudo mv composer.phar /usr/local/bin/composer

install_docker
install_chrome
install_vscode
install_notion
install_spotify
set_wallpaper

echo "Installation complete! ✅"
