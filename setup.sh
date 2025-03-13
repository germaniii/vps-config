#!/bin/bash

echo "####################################################"
echo "# Hello! Welcome to the VPS-config setup"
echo "####################################################"
sleep 0.5

echo "Here are the steps that we will be doing:"
sleep 0.1
echo "- Update the system"
sleep 0.1
echo "- Clone the vps-config repository"
sleep 0.1
echo "- Install Tailscale"
sleep 0.1
echo "- Setup the firewall"
sleep 0.1
echo "- Setup Docker"
sleep 0.1
echo "- Reboot"
echo
echo

echo "####################################################"
echo "# Updating System"
echo "####################################################"
sudo apt update && sudo apt upgrade -y

echo
echo "Installing git and ufw"
echo
sudo apt install git ufw -y
echo
echo

echo "####################################################"
echo "# Cloning Repository"
echo "####################################################"
git clone https://github.com/germaniii/vps-config
echo
echo

echo "####################################################"
echo "# Setting up VPN"
echo "####################################################"
curl -fsSL https://tailscale.com/install.sh | sh
echo "####################################################"
echo "# Setting up Firewall"
echo "####################################################"
echo
echo

echo "Enabling ufw"
echo
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow in on tailscale0
echo
echo

echo "####################################################"
echo "# Current UFW settings"
echo "####################################################"
sudo ufw status verbose
echo
echo

sudo ufw reload
sudo service ssh restart

echo "####################################################"
echo "# Setting up Docker"
echo "####################################################"
curl -fsSL https://get.docker.com | sh
sudo apt install docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable --now docker
echo
echo

sudo reboot
