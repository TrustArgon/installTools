#!/bin/bash

#update apt sources
apt-get update

#install pip for python module installations
apt install -y python-pip python3-pip build-essential dnsrecon perl polenum samba ldap-utils smbclient p0f wireshark sqlmap libxml2-utils binwalk volatility libhttp-dav-perl mitmproxy libcap-dev net-tools hashcat hydra medusa john john-data ruby ruby-dev libruby


#create directory for downloaded tools
mkdir /root/tools

#install hashcat
apt install -y hashcat

#install nmap
apt install -y nmap

#install tcpdump
apt install -y tcpdump

#install nikto
apt install -y nikto

#install dirb
##download dirb tar archive
cd /root/tools
wget -O dirb.tar.gz https://downloads.sourceforge.net/project/dirb/dirb/2.22/dirb222.tar.gz
##extract archive
tar -xf dirb.tar.gz
chmod -R a+X dirb222/
cd dirb222
chmod a+x configure
./configure
make
ln -s /root/tools/dirb222/dirb /usr/local/bin/dirb
mv dirb /usr/local/bincurl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
cd /root/tools
rm dirb.tar.gz

#install impacket
apt install -y python-impacket

#install chromium (necessary for aquatone to function)
apt install -y chromium

#install aquatone
cd /root/tools
mkdir aquatone
cd aquatone
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
unzip aquatone_linux_amd64_1.7.0.zip
ln -s /root/tools/aquatone/aquatone /usr/local/bin/aquatone

#install sublist3r
cd /root/tools
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
pip install -r requirements.txt
ln -s /root/tools/Sublist3r/sublist3r.py /usr/local/bin/sublist3r

#install dirsearch
cd /root/tools
git clone https://github.com/maurosoria/dirsearch.git
ln -s /root/tools/dirsearch/dirsearch.py /usr/local/bin/dirsearch

#install metasploit
mkdir /root/tools/metasploit
cd /root/tools/metasploit
## download installer
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
## give execute permissions to installer
chmod +x msfinstall
## execute installer
./msfinstall

#install powershell-empire (BC-Security fork)
cd /root/tools
git clone https://github.com/BC-SECURITY/Empire.git
cd Empire
## fix database setup script to remove interactive element
sed -i '27s/.*/    choice = ""/' /root/tools/Empire/setup/setup_database.py
./setup/install.sh

#install Covenant (this is a bit complex with its dependencies)
apt install liblttng-ust0 libcurl3 libkrb5-3 zlib1g libicu57
cd /root/tools
wget https://download.visualstudio.microsoft.com/download/pr/022d9abf-35f0-4fd5-8d1c-86056df76e89/477f1ebb70f314054129a9f51e9ec8ec/dotnet-sdk-2.2.207-linux-x64.tar.gz
mkdir $HOME/dotnet
tar zxf dotnet-sdk-2.2.207-linux-x64.tar.gz -C $HOME/dotnet
echo 'export PATH=$PATH:$HOME/dotnet' >> $HOME/.bashrc
echo 'export DOTNET_ROOT=$HOME/dotnet' >> $HOME/.bashrc

git clone --recurse-submodules https://github.com/cobbr/Covenant
cd Covenant/Covenant
dotnet build

#install dnsmap
cd /root/tools
git clone https://gitlab.com/kalilinux/packages/dnsmap.git
cd dnsmap
make install

#install enum4linux
git clone https://github.com/portcullislabs/enum4linux.git
ln -s /root/tools/enum4linux/enum4linux.pl /usr/local/bin/enum4linux

#install smbmap
cd /root/tools
git clone https://salsa.debian.org/pkg-security-team/smbmap.git
cd smbmap
python3 -m pip install -r requirements.txt
ln -s /root/tools/smbmap/smbmap.py /usr/local/bin/smbmap

#install searchsploit and exploitdb
git clone https://github.com/offensive-security/exploitdb.git /opt/exploitdb
sed's|path_array+=(.*)|path_array+=("/opt/exploitdb")|g' /opt/exploitdb/.searchsploit_rc > ~/.searchsploit_rc
ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit

git clone https://github.com/offensive-security/exploitdb-bin-sploits /opt/exploitdb/binaries
git clone https://github.com/offensive-security/exploitdb-papers /opt/exploitdb/papers

#install davtest
cd /root/tools
git clone https://github.com/cldrn/davtest.git
ln -s /root/tools/davtest/davtest.pl /usr/local/bin/davtest

#install go environment
cd /root/tools
wget https://dl.google.com/go/go1.14.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.14.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.bashrc
source $HOME/.bashrc

cd /root/tools
git clone https://github.com/OJ/gobuster.git
cd gobuster
go get && go build
ln -s /root/go/bin/gobuster /usr/local/bin/gobuster

#install bettercap
mkdir /root/tools/bettercap
cd /root/tools/bettercap
wget https://github.com/bettercap/bettercap/releases/download/v2.26.1/bettercap_linux_amd64_v2.26.1.zip
unzip bettercap_linux_amd64_v2.26.1.zip
ln -s /root/tools/bettercap/bettercap /usr/local/bin/bettercap

#install hashid
pip3 install hashid

#install weevely
cd /root/tools
git clone https://github.com/epinna/weevely3.git
cd weevely3
pip3 install -r requirements.txt --upgrade

#install cfr java decompiler
mkdir /root/tools/cfr
cd /root/tools/cfr
wget https://www/benf.org/other/cfr/cfr-0.148.jar
echo 'alias cfr="java -jar /root/tools/cfr/cfr-0.148.jar"' >> $HOME/.bashrc

# get ZAP installer script
wget https://github.com/zaproxy/zaproxy/releases/download/v2.9.0/ZAP_2_9_0_unix.sh

# install whatweb
cd /root/tools
git clone https://github.com/urbanadventurer/WhatWeb.git
cd WhatWeb
gem install bundler
bundle install
ln -s /root/tools/WhatWeb/whatweb /usr/local/bin/WhatWeb
