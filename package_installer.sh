#!/bin/bash

#Verify that the script is run with root access
if [ $EUID -ne 0 ]; then
	echo "This script must be run with root access"
        exit 1
fi

#Check if at least one parameter is given
if [ -z "$1" ]; then
	echo "You must provide at least one package"
	echo "Usage $0 {Packages}"
        exit 1
fi


#Check if the system has at least 256MB memory 
MEMFREE=$(free -m | awk ' $1=="Mem:" {print $4}')


if [ $MEMFREE -lt 256 ]; then
	echo "Not enough memory to run this action"
	exit 1
fi


#Check if the system is RHEL or Debian based to decide the package manager
if grep -i debian /etc/os-release; then
	PACKAGEMANAGER=apt
else
	PACKAGEMANAGER=dnf
fi

#Install all the packages given, check if there is unit files start and enable the service
for PACKAGE in "$@"; 
do
	echo "Installing $PACKAGE"
        $PACKAGEMANAGER install $PACKAGE -y
        if systemctl list-unit-files | grep -q "^${PACKAGE}.service"; then
		echo "Starting and enabling $PACKAGE"
		systemctl enable $PACKAGE && systemctl start $PACKAGE
	else
		echo "$PACKAGE does not have a systemd service unit. Skipping."
	fi
done

