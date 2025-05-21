#!/bin/bash

echo "Starting the configuration setup for UFW..."
if ! command -v ufw &> /dev/null
then
  echo "UFW is not installed"
  apt-get update
  apt-get install -y ufw


echo "Setting up default policies..."
ufw default deny incoming
ufw default allow outgoing
