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

# Function to add a repository and key
add_repository() {
    echo "Adding repository: $1..."
    echo "$2" | sudo tee /etc/apt/sources.list.d/$1.list
    for i in {1..3}; do
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $3 && break || echo "Retrying key import..."
        sleep 5
    done
}

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common || echo "Failed to install dependencies for Docker, continuing..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - || echo "Failed to add Docker key, continuing..."
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y docker-ce || echo "Failed to install Docker, continuing..."
    sudo systemctl start docker
    sudo systemctl enable docker
}

# Function to install Google Chrome
install_chrome() {
    echo "Installing Google Chrome..."
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - || echo "Failed to add Chrome key, continuing..."
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update
    sudo apt install -y google-chrome-stable || echo "Failed to install Chrome, continuing..."
}

# Function to install VS Code
install_vscode() {
    echo "Installing Visual Studio Code..."
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - || echo "Failed to add VS Code key, continuing..."
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install -y code || echo "Failed to install VS Code, continuing..."
}

# Function to install Neofetch
install_neofetch() {
    echo "Installing Neofetch..."
    sudo apt install -y neofetch || echo "Failed to install Neofetch, continuing..."
    echo "neofetch" >> ~/.bashrc
}

# Function to install MySQL
install_mysql() {
    echo "Installing MySQL Server..."
    sudo apt install -y mysql-server || echo "Failed to install MySQL, continuing..."
    sudo systemctl start mysql
    sudo systemctl enable mysql
}

# Function to install PostgreSQL
install_postgresql() {
    echo "Installing PostgreSQL..."
    sudo apt install -y postgresql postgresql-contrib || echo "Failed to install PostgreSQL, continuing..."
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
}

# Function to install Notion desktop
install_notion() {
    echo "Installing Notion desktop..."
    wget -qO- https://notion.davidbailey.codes/notion-linux.list | sudo tee /etc/apt/sources.list.d/notion-linux.list
    wget -qO - https://notion.davidbailey.codes/notion.asc | sudo apt-key add - || echo "Failed to add Notion key, continuing..."
    sudo apt update
    sudo apt install -y notion-app-enhanced || echo "Failed to install Notion, continuing..."
}

# Function to install Spotify
install_spotify() {
    echo "Installing Spotify..."
    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - || echo "Failed to add Spotify key, continuing..."
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt install -y spotify-client || echo "Failed to install Spotify, continuing..."
}

# Function to set wallpaper
set_wallpaper() {
    echo "Setting wallpaper..."
    wget -O /tmp/temp_wallpaper.png "https://i.redd.it/g8ud4yocwbeb1.png" || echo "Failed to download wallpaper, continuing..."
    gsettings set org.gnome.desktop.background picture-uri "file:///tmp/temp_wallpaper.png" || echo "Failed to set wallpaper, continuing..."
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

curl -sS https://getcomposer.org/installer | php || echo "Failed to install Composer, continuing..."
sudo mv composer.phar /usr/local/bin/composer

install_docker
install_chrome
install_vscode
install_neofetch
install_mysql
install_postgresql
install_notion
install_spotify
set_wallpaper

echo "Installation complete! ✅"
