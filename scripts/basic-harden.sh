#!/bin/bash

# This script is for setting up a basic security on the VM running the Nginx server

apt-get update
apt-get upgrade -y
apt-get install fail2ban -y
