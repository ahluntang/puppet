#!/usr/bin/env bash

wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
sudo apt-get install -y puppetmaster puppetmaster-passenger
sudo puppet resource service puppetmaster ensure=running enable=true
