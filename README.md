# aster.sh

A bash wrapper around tsh for easier installation, setup and connectivity


tsh is a cli for the teleport application and is used as a access proxy for the services. 

You can learn more about the  teleport tool [here](https://github.com/gravitational/teleport)

This script is mostly based for linux based systems

## Pre-Requisites
- curl
- tar
- jq

You do not need to install any pre-requisites. The wrapper will install it for you.

For aster.sh to run, 
- Clone the repo
- run the ```./install``` script to run it globally or you can just use it with ```./aster.sh```
- you can start using aster.sh by pressing ```aster.sh``` anywhere from your system.

### tsh installation workflow
```
> ./aster.sh 

aster.sh - A bash wrapper around tsh for its easier installation of tsh command line and the first-time configuration.
Please provide the teleport proxy domain below
teleport.example.com
Choose from [1-4] to do specific functions from cloudflare
1.Install the tsh 
2.Login with Github
3.Create MongoDB connection with remote server on your local machine
4.Exit
1
Updating system...
W: https://deb.nodesource.com/node_16.x/dists/jammy/InRelease: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
W: https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/6.0/Release.gpg: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
Making sure you have the pre-requisites installed
Your proxy server has 13.3.8 installed. So installing the same version on the system
Starting Teleport installation...
Teleport binaries have been copied to /usr/local/bin

Thanks for installing Teleport.

Is it OK if we collect some info about your install?
Please run this command to send in a survey.
Optional: Replace email to join our newsletter and get a swag package.
$ curl -X POST https://usage.teleport.dev -F OS=linux -F use-case="access my ..." -F email="alice@example.com"

Otherwise, ignore!
The tsh has been installed. The output version is
Teleport v13.3.8 git:api/v13.3.8-0-gc95e235 go1.20.7
Proxy version: 13.3.8
Proxy: teleport.example.com:443

```

###Tsh Github login

```

> ./aster.sh 
aster.sh - A bash wrapper around tsh for its easier installation of tsh command line and the first-time configuration.
Please provide the teleport proxy domain below
teleport.example.com
Choose from [1-4] to do specific functions from cloudflare
1.Install the tsh 
2.Login with Github
3.Create MongoDB connection with remote server on your local machine
4.Exit
2
Checking if the tsh is installed
The tsh has been installed. The output version is
Teleport v13.3.8 git:api/v13.3.8-0-gc95e235 go1.20.7
Please provide your github username:
amanasterdio
Please provude the connector name:
asterdio_connector
WARNING: Ignoring Teleport user (amanasterdio) for Single Sign-On (SSO) login.
Provide the user name during the SSO flow instead. Use --auth=local if you did not intend to login with SSO.
If browser window does not open automatically, open it by clicking on the link:
 http://127.0.0.1:46107/aa60823e-5794-4f13-a155-c5676c549ce3


```
### MongoDB connection workflow
```
> ./aster.sh 
aster.sh - A bash wrapper around tsh for its easier installation of tsh command line and the first-time configuration.
Please provide the teleport proxy domain below
teleport.example.com
Choose from [1-4] to do specific functions from cloudflare
1.Install the tsh 
2.Login with Github
3.Create MongoDB connection with remote server on your local machine
4.Exit
3
Checking if the tsh is installed
The tsh has been installed. The output version is
Teleport v13.3.8 git:api/v13.3.8-0-gc95e235 go1.20.7
Proxy version: 13.3.8
Proxy: teleport.example.com:443
Printing the available hosts for connetion from tsh                               

Please provide the host from which you want to connect the MongoDB to. Please provide the complete label like:
hostname=Example-UAT,azure/Example=UAT
hostname=Example-UAT,azure/Example=UAT
Also please provide the server username to use.
azureuser
Are there any specific ports you want to open your connection in your local system. It uses 27017 on the remote system for MongoDB. This is helpful when you are connecting to different databases at the same time
27020
Here's the mongodb url to connect to the server.
The connected DB is for hostname=Example-UAT,azure/Example=UAT.
You can connect it using:
mongodb://username:password@localhost:27020
Press Ctrl+c to cancel the connection

```