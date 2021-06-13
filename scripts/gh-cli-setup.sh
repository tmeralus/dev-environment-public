# Script to use and authenticate github-cli
# input gh token

# SETUP AND INSTALL GH CLI
echo "SET GH TOKEN"
touch scripts/mytoken.txt
echo "CHECKING DISTROS" ##&& sleep 2
if [ -d "$YUM_DIST" ] && ! [ -x "$(command -v gh)" ]
then
  echo "YUM DISTRO  found" ##&& sleep 2
  sudo yum config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo yum update -y
  sudo yum install gh
elif [ -d "$APT_DIST" ]; && ! [ -x "$(command -v gh)" ]
then
  echo "APT package distro found" ##&& sleep 2
  echo "setup and install github-cli"
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
  sudo apt-add-repository https://cli.github.com/packages
  sudo apt install gh
  sudo apt clean
else
  echo "No APT or YUM package manager found"
  echo "GH-CLI not found"
  break
#  break
fi

# SETUP GH TOKEN ACCESS AND ENV VARS
echo "Checking GHTOKEN environment variable"
if [ -z "$GHTOKEN" ]
then
      echo "GHTOKEN is empty" && sleep 3
      echo "MUST HAVE GHTOKEN SET TO CONTINUE!"
      echo "PASTE GH TOKEN NOW!"
      echo "type gh token key here"
      read NEWTOKEN
      echo $NEWTOKEN > scripts/mytoken.txt
      export GHTOKEN="scripts/mytoken.txt"
      echo "CREATED SYSTEM ENV VAR"
else
      echo "GHTOKEN found"
fi

# AUTHENTICATE GH-CLI FOR SETUUPING UP REPOS
if ! [ -x "$(command -v gh)" ];
then
  echo 'gh-cli not setup INSTALLING now...' #&& sleep 2
  $UPDATE
  $INSTALL gh # move gh setup to before other packages are installed
  echo "USING GH-CLI TO AUTHENTICATE"
  gh auth login --with-token < scripts/mytoken.txt

else
  echo "GH-CLI INSTALLED NOW"
fi

# CONFIGURE GH-CLI GLOBAL VARS
echo "setting up config variables"
gh config set editor nano
gh config set editor "code --wait"
gh config set git_protocol ssh --host github.com
gh config set prompt disabled

# PULL GITHUB REPOS
echo "PULL GITHUB REPOS WITH GH-CLI" && sleep 2
sh scripts/gh-pull.sh
# clear gh token to prevent saving to git repo
echo "Clearing gh auth token"
echo "gh auth token goes here" > scripts/mytoken.txt
