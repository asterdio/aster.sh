#!/bin/bash

echo "
aster.sh - A bash wrapper around tsh for its easier tsh functions.

Version: 1.0.0

Please provide the teleport proxy domain below"

read teleport_proxy_url

echo "
Choose from [1-4] to do specific functions from tsh.

1.Install the tsh

2.Login with Github

3.Create MongoDB connection with remote server on your local machine

4.Exit
"

read tsh_option

tsh_installed() {
    tsh_installed_version=$(tsh version)
    echo "
The tsh has been installed. 
The output version is
$tsh_installed_version
    "
}
if [ $tsh_option -eq 1 ]; then
    echo "Updating system..."
    sudo apt-get update -y > /dev/null

    # Install required packages
    echo "Making sure you have the pre-requisites installed"
    sudo apt-get install curl jq tar -y > /dev/null

    #Finding the current proxy server's teleport version 
    tsh_version=$(curl -s https://$teleport_proxy_url/webapi/find | jq -r '.server_version')
    echo "Your proxy server has $tsh_version installed. So installing the same version on the system"

    #Installing the compatible tsh version
    curl -O -s https://cdn.teleport.dev/teleport-v$tsh_version-linux-amd64-bin.tar.gz
    
    #extracing the packages
    tar -xzf teleport-v$tsh_version-linux-amd64-bin.tar.gz
    sudo sh teleport/install
    rm -rf teleport-v$tsh_version-linux-amd64-bin.tar.gz teleport
    tsh_installed
elif [ $tsh_option -eq 2 ]; then
    echo "Checking if the tsh is installed"
    tsh_installed
    echo "
Please provide your github username:
        "
    read github_username
    echo "
Please provide the connector name:
    "
    read connector_name
    tsh login --user=$github_username --proxy=$teleport_proxy_url --auth=$connector_name
elif [ $tsh_option -eq 3 ]; then
    echo "Checking if the tsh is installed"
    tsh_installed
    echo "
Printing the available hosts for connetion from tsh
    "
    node_list=$(tsh ls)
    echo "
        $node_list
        
        "
    echo "
Please provide the host from which you want to connect the MongoDB to. 
Please provide the complete label like:
hostname=Example-UAT,azure/Example=UAT
    "
    read node_labels
    echo "
Also please provide the server username to use.
        "
    read server_username
    echo "
Are there any specific ports you want to open your connection in your local system. 
It uses 27017 on the remote system for MongoDB. 
This is helpful when you are connecting to different databases at the same time
        "
    read mongodb_port
    echo "
Here's the mongodb url to connect to the server.
The connected DB is for $node_labels.
You can connect it using:
mongodb://username:password@localhost:$mongodb_port
Press Ctrl+c to cancel the connection
        "
    tsh ssh -L $mongodb_port:localhost:27017 -N $server_username@$node_labels 
else
    echo "Thank you for using aster.sh. Hope you have a bug-free day"
fi