#!/bin/bash

# jenkins installation script

# update the server repository

sudo apt update -y && sudo apt upgrade -y

# This is the Debian package repository of Jenkins to automate installation and upgrade. To use this repository, first add the key to your system:

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Then add a Jenkins apt repository entry:

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update your local package index, then finally install Jenkins:

sudo apt-get update
sudo apt-get install fontconfig openjdk-17-jre

# Update system package list
echo "Updating package list..."
sudo apt-get update -y

# Install Jenkins
echo "Installing Jenkins..."
sudo apt-get install -y jenkins

# Check the installation status
if dpkg-query -W -f='${Status}' jenkins 2>/dev/null | grep -q "install ok installed"; then
    echo "Jenkins installation successful"
else
    echo "Jenkins installation failed"
fi

# Start Jenkins service....
echo "Start Jenkins service...."
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Verify Jenkins is running ...
echo "Verifying Jenkins is running ..."
sudo systemctl status jenkins
