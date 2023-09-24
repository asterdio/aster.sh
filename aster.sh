#!/bin/bash

printf "aster.sh - A bash wrapper around tsh for its easier installation of tsh command line and the first-time configuration.\nPlease provide the teleport proxy domain below\n"

read teleport_proxy_url

printf "Choose from [1-4] to do specific functions from cloudflare\n1.Install the tsh \n2.Login with Github\n3.Create MongoDB connection with remote server on your local machine\n4.Exit\n"

read tsh_option

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
    tsh_installed_version=$(tsh version)
    printf "The tsh has been installed. The output version is\n$tsh_installed_version"
elif [ $tsh_option -eq 2 ]; then
    echo "Checking if the tsh is installed"
    tsh_installed_version=$(tsh version)
    printf "The tsh has been installed. The output version is\n$tsh_installed_version\n"
    printf "Please provide your github username:\n"
    read github_username
    printf "Please provude the connector name:\n"
    read connector_name
    tsh login --user=$github_username --proxy=$teleport_proxy_url --auth=$connector_name
elif [ $tsh_option -eq 3 ]; then
    echo "Checking if the tsh is installed"
    tsh_installed_version=$(tsh version)
    printf "The tsh has been installed. The output version is\n$tsh_installed_version\n"
    printf "Printing the available hosts for connetion from tsh\n"
    node_list=$(tsh ls)
    printf "$node_list\n\n"
    printf "Please provide the host from which you want to connect the MongoDB to. Please provide the complete label like:\nhostname=BUYPARTS24-UAT,azure/Buyparts24=UAT\n"
    read node_labels
    printf "Also please provide the server username to use.\n"
    read server_username
    printf "Are there any specific ports you want to open your connection in your local system. It uses 27017 on the remote system for MongoDB. This is helpful when you are connecting to different databases at the same time\n"
    read mongodb_port
    printf "Here's the mongodb url to connect to the server.\nThe connected DB is for $node_labels.\nYou can connect it using:\nmongodb://username:password@localhost:$mongodb_port\nPress Ctrl+c to cancel the connection\n"
    tsh ssh -L $mongodb_port:localhost:27017 -N $server_username@$node_labels 
else
    printf "Thank you for using aster.sh. Hope you have a bug-free day"
fi