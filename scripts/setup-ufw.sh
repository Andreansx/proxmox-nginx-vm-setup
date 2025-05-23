#!/bin/bash

# Remember, This file needs to have execute permissions
# Run this comand: sudo chmod +x ./setup-ufw.sh
# Run this script with sudo permissions: sudo ./setup-ufw.sh
# Tested on Debian 12.11.0

echo "Starting the configuration setup for UFW..."

ok="[  \e[1;32mOK\e[0m  ]"
er="[  \e[1;31mERROR\e[0m  ]:"
wr="[  \e[1;33mWARNING\e[0m  ]:"
if ! command -v ufw &> /dev/null
then
  echo "UFW is not installed"
  echo -e ">>> Starting entire system upgrade\n"
  apt-get update
  apt-get upgrade -y
  apt-get install -y ufw
  if [ $? -ne 0 ]
  then
    echo -e "$er Couldn't install UFW.. Aborting"
    exit 1
  fi
  echo -e "$ok Sucessfulyl insttalled UFW\n"
fi

echo -e "Setting up default policies..."
ufw default deny incoming
ufw default allow outgoing
echo -e "$ok Sucessfully set up defaulf policies"

echo -e "$ok Setting up specific rules..."

ufw allow 80/tcp comment "Web server HTTP"
if [ $? -ne 0 ]
then
  echo -e "$er Couldn't setup HTTP rule"
  exit 1
else
  echo -e "$ok Set up HTTP rule"
fi

ufw allow 443/tcp comment "Web server HTTPS"
if [ $? -ne 0 ]
then
  echo -e "$er Couldn't setup HTTPS rule"
  exit 1
else
  echo -e "$ok Set up HTTPS rule"
fi

echo -e "$wr"
read -p "Are you sure you want to enable UFW ? ( [Y]es/[N]o )" confirm_enable
if [[ "$confirm_enable" =~ ^[Yy]$ ]]
then
  echo "Enabling UFW.."
  yes | ufw enable
  if [ $? -ne 0 ]
  then
    echo -e "$er Couldn't enable UFW\n"
    exit 1
  fi
  echo -e "$ok UFW has been successfully enabled\n"
else
  echo -e "$wr UFW has not been enabled. Remember to enable it later"
fi

echo ""

echo -e "$ok Showing current UFW status.."

ufw status verbose

echo -e "$ok Finished setup\n\n"
