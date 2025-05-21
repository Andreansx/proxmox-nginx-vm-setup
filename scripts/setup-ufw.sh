#!/bin/bash

# Remember, This file needs to have execute permissions
# Run this comand: chmod +x ./setup-ufw.sh
# Run this script with sudo permissions: sudo ./setup-ufw.sh

echo "Starting the configuration setup for UFW..."
if ! command -v ufw &> /dev/null
then
  echo "UFW is not installed"
  apt-get update
  apt-get install -y ufw
fi

echo "Setting up default policies..."
ufw default deny incoming
ufw default allow outgoing

echo "Setting up specific rules..."
ufw allow 80/tcp comment "Web server HTTP"
ufw allow 443/tcp comment "Web server HTTPS"
echo ""
read -p "Are you sure you want to enable UFW ? ( [Y]es/[N]o )" confirm_enable
if [[ "$confirm_enable" =~ ^[Yy]$ ]]
then
  echo "Enabling UFW.."
  yes | ufw enable
fi