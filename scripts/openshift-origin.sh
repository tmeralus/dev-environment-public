#quick script to install openshift-origin on ubuntu

if [ ! -f "/usr/local/bin/oc" ];
then
  wget $OCP_URL
  tar xvf openshift-origin-client-tools*.tar.gz
  echo "Copying oc and kubectl binaries" && sleep 5
  sudo mv  openshift-origin-client*/oc  /usr/local/bin/
  sudo mv  openshift-origin-client*/kubectl  /usr/local/bin/
else
  echo "Openshift Origin tar file found" && sleep 3
  echo "Skipping Download" && sleep 3
fi

# Setup insecure-registries for openshift
if grep -Fxq "insecure-registries" /etc/docker/daemon.json
then
  cat << EOF | sudo tee /etc/docker/daemon.json
  {
      "insecure-registries" : [ "172.30.0.0/16" ]
  }
EOF
  echo "RESTARTING DOCKER"
  sudo systemctl restart docker
else
  echo "Docker registry configuration already set" && sleep 3
fi

if [ ! -f "/usr/local/bin/kompose" ]:
then
  echo "Kompose tool not found" && sleep 4
  echo "Installing Kompose for openshift" && sleep 4
  curl -L https://github.com/kubernetes/kompose/releases/download/v1.21.0/kompose-linux-amd64 -o kompose
  chmod +x kompose
  sudo mv ./kompose /usr/local/bin/
else
  echo "Kompose tool found"
fi
echo "openshift should be setup now" && sleep 3
echo "login info can be found in OPENSHIFT-ORIGIN.md file"
echo "To login as administrator:"
echo "     oc login -u system:admin"
echo "or run oc cluster up" && sleep 3
