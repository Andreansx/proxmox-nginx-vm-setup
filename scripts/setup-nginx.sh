#!/bin/bash

# This script installs and completes basic configuration for Nginx web server
# Apply the execute permission: sudo chmod +x ./setup-nginx.sh
# Run with sudo priveleages

ok="[  \e[1;32mOK\e[0m  ]"
apt-get update
if [ $? -ne 0 ]
then
  exit 1
else
  echo -e "$ok Sucessfully updated package list"
fi

echo "Checking for nginx existence.."
if command ! -v nginx & /dev/null
then
  echo ">>> Begining Nginx install"
  apt-get install nginx
  if [ $? -ne 0 ]; then; 
  
