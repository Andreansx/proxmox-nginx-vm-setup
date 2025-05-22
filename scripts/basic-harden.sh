#!/bin/bash

# This script is for setting up a basic security on the VM running the Nginx server
ok="[  \e[1;32mOK\e[0m  ]"
er="[  \e[1;33mERROR\e[0m  ]:"
wr="[  \e[1;33mWARNING\e[0m  ]:"
apt-get update
apt-get upgrade -y
apt-get install fail2ban -y
