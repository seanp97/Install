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
