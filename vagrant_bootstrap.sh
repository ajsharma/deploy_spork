#!/bin/bash

####
# This script can be used to setup development (vagrant) environments
####

echo "Beginning vagrant bootstrap"

# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
# First argument is the name of the package(s)
# Remaining arguments as passed to apt-get
function aginstall {
    echo installing $1
    shift
    # apt-get -qq
    # apt-get -y
    apt-get -y install "$@" >/dev/null 2>&1
}

echo "Setting operating system locale"
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo "Add a swap file to make better use of Memory"
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

echo "Updating apt-get"
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

aginstall "Core development tools" curl build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
aginstall "Git" git-core

aginstall "Ruby" ruby2.3 ruby2.3-dev
update-alternatives --set ruby /usr/bin/ruby2.3 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.3 >/dev/null 2>&1

echo "Installing bundler"
cd /vagrant
gem install --no-ri --no-rdoc bundler

echo "Installing nodejs"
apt-get -qq install software-properties-common
apt-get -y update >/dev/null 2>&1
apt-get -qq install -y python-software-properties python g++ make
add-apt-repository -y ppa:chris-lea/node.js
apt-get -y update >/dev/null 2>&1

aginstall 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
aginstall 'ExecJS runtime' nodejs

echo "Updating PostgreSQL sources"
# See also:
# * https://gorails.com/setup/ubuntu/14.04
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

apt-get -y update >/dev/null 2>&1

aginstall "PostgreSQL" postgresql-9.4 postgresql-contrib libpq-dev
sudo -u postgres createuser --superuser vagrant
sudo -u postgres createdb -O vagrant vagrant

aginstall "Redis" redis-server
