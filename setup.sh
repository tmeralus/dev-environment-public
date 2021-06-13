#!/bin/bash
# author: tmeralus
# Bash script to Install ansible, pip, git, wget, and setup my dev environment with ansible
# Defined Variables
YUM_DIST="/etc/yum.repos.d/"
APT_DIST="/etc/apt/sources.list.d/"
YUM_INSTALL='sudo yum install -y'
APT_INSTALL='sudo apt-get install -y'
SNAP_INSTALL='sudo snap install'
APT_UPDATE="sudo apt-get update -y"
YUM_UPDATE="yum update -y"
USER_NAME='tmeralus'
USER_EMAIL="example@gmail.com"
OCP_FILE='openshift-origin-client-tools-*.tar.gz'
OCP_URL='https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz'

echo "SETTING UP DEV ENVIRONMENT"
sudo -v
# check yum or apt
echo "CHECKING DISTROS" ##&& sleep 2
if [ -d "$YUM_DIST" ];
then
  echo "Yum package distro found" ##&& sleep 2
  INSTALL="$YUM_INSTALL"
  UPDATE="$YUM_UPDATE"
  echo "Installing EPEL Repo"
  sudo yum install epel-release -y
  echo "Updating Repos"
  sudo yum update -y
  $INSTALL $(awk '{print $1'} scripts/pkg/yum.list)
elif [ -d "$APT_DIST" ];
then
  echo "APT package distro found" ##&& sleep 2
  INSTALL="$APT_INSTALL"
  UPDATE="$APT_UPDATE"
  $APT_UPDATE
  $INSTALL $(awk '{print $1'} scripts/pkg/apt.list)
  sudo apt clean
else
  echo "No APT or YUM package manager found"
#  break
fi

echo " INSTALLING PACKAGE BASE"
$INSTALL $(awk '{print $1'} scripts/pkg/pkg.list)
echo " INSTALLING IDE" && sleep 3

echo "setup crontab script"
cp files/crontabs/cleantrash.sh /home/tmeralus/

echo "INSTALLING WORK RELATED PACKAGES" && sleep 7
sh scripts/pkg/work-pkg.sh
sudo snap install onenote-desktop --beta

echo "SETUP AND ENABLE DOCKER"
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl restart docker

echo "SETTING GLOBAL GIT VARIABLES" #&& sleep 2
git config --global user.name $USER_NAME
git config --global user.email $USER_EMAIL
git config --global core.editor nano

echo "Update pip in python3"
python3 -m pip install --user --upgrade pip
pip3 uninstall ansible
pip3 install -r requirements.txt

echo "create temp dirs"
mkdir /home/$USER_NAME/temp
echo "setup ansible playbooks"
mkdir /home/$USER_NAME/github/ansible
mkdir /home/$USER_NAME/github/ansible/roles
mkdir /home/$USER_NAME/github/ansible/inventory
mkdir /home/$USER_NAME/temp
sudo touch /var/log/ansible.log
sudo chown $USER_NAME:$USER_NAME /var/log/ansible.log
sudo cp -R playbook/files/dev-hosts /home/$USER_NAME/github/ansible/inventory/dev
sudo cp -R playbook/files/ansible.cfg /etc/ansible/ansible.cfg
sudo chown $USER_NAME:$USER_NAME -R /home/$USER_NAME/github/ansible/inventory/dev

echo "RUNNING ANSIBLE PLAYBOOK"
ansible-playbook playbook/playbook.yml

echo "SETUP GITHUB CLI" && sleep 3
sh scripts/gh-cli-setup.sh
echo "SETUP OPENSHIFT ORIGIN"  && sleep 3
sh scripts/openshift-origin.sh

echo "SCRIPT COMPLETED"
