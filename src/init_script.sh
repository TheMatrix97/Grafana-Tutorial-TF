#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade

# Clean Docker
sudo apt-get -y remove docker docker-engine docker.io containerd runc

# Install Docker
sudo apt-get -y install ca-certificates curl gnupg lsb-release
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get -y install git docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Get repo

git clone https://github.com/grafana/tutorial-environment.git

cd tutorial-environment

docker compose up -d

