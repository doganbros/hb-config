#!/bin/bash
echo "Unique ID  = $1"
echo "GIT URL = $2"
echo "Creating config directories"
mkdir "/home/ec2-user/test-hummingbot-config"
mkdir "/home/ec2-user/test-hummingbot-config/$1"
echo "CD to base config..."
cd "/home/ec2-user/test-hummingbot-config/$1" 
echo "Downloading config files..."
wget "$2"
echo "Unzipping config files..."
unzip master 
echo "Removing zip file..."
rm master.zip
echo "Moving config files..."
mv hb-config-master hummingbot_files
cd hummingbot_files
mkdir hummingbot_scripts
mkdir hummingbot_certs
echo "Setting up permitions..."
chmod -R 777 /home/ec2-user/test-hummingbot-config 
