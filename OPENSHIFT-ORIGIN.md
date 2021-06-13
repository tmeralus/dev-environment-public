Start OpenShift Origin All-in-One Server

Start OKD server by running the following command:

$ oc cluster up

The command above will:

    Start OKD Cluster listening on local interface – 127.0.0.1:8443
    Start a web console listening on all interfaces at /console (127.0.0.1:8443).
    Launch Kubernetes system components.
    Provisions registry, router, initial templates, and a default project.

There are a number of options which can be applied when setting up Openshift Origin, view them with:

$ oc cluster up --help

On a successful installation, you should get output similar to below.

Login to server …
Creating initial project "myproject" …
Server Information …
OpenShift server started.
The server is accessible via web console at:
     https://127.0.0.1:8443
You are logged in as:
     User:     developer
     Password: <any value>
To login as administrator:
     oc login -u system:admin

Example below uses custom options.

$ oc cluster up --routing-suffix=<ServerPublicIP>.xip.io \
 --public-hostname=<ServerPulicDNSName>

Or Just public/Private IP

oc cluster up --public-hostname=192.168.10.10

OpenShift cluster configuration files will be located inside the openshift.local.clusterup/ directory.

To login as administrator, use:

$ oc login -u system:admin
Logged into "https://116.203.125.128:8443" as "system:admin" using existing credentials.
You have access to the following projects and can switch between them with 'oc   project ':
* default
 kube-dns
 kube-proxy
 kube-public
 kube-system
 myproject
 openshift
 openshift-apiserver
 openshift-controller-manager
 openshift-core-operators
 openshift-infra
 openshift-node
 openshift-service-cert-signer
 openshift-web-console 
 Using project "default.

Change to the default project:

oc project default

Deploy OKD cluster integrated container image registry if it doesn’t exist.

$ oc adm registry
Docker registry "docker-registry" service exists

Check current project status.

$ oc status
 In project default on server https://192.168.10.10:8443
 svc/docker-registry - 172.30.1.1:5000
   dc/docker-registry deploys docker.io/openshift/origin-docker-registry:v3.11 
     deployment #1 deployed about an hour ago - 1 pod
 svc/kubernetes - 172.30.0.1:443 -> 8443
 svc/router - 172.30.119.192 ports 80, 443, 1936
   dc/router deploys docker.io/openshift/origin-haproxy-router:v3.11 
     deployment #1 deployed about an hour ago - 1 pod
 View details with 'oc describe /' or list everything with 'oc get all'.

Creating a Project on OKD

Now that we have OKD installed and working, we can test the deployment by deploying a test project. Switch to test user account.

$ oc login
Authentication required for https://116.203.125.128:8443 (openshift)
Username: developer
Password: developer
Login successful.

Confirm if Login was successful.

$ oc whoami
developer

Create a new project using oc new-project command.

$ oc new-project dev --display-name="Project1 - Dev" --description="My Dev Project"

Access Admin Console in a browser

OKD includes a web console which you can use for creation and management actions. This web console is accessible on Server IP/Hostname on the port,8443 via https.

https://<IP|Hostname>:8443/console

If you are redirected to https://127.0.0.1:8443/ when trying to access OpenShift web console, then do this:

1. Stop OpenShift Cluster

$ oc cluster down

2. Edit OCP configuration file.

$ nano ./openshift.local.clusterup/openshift-controller-manager/openshift-master.kubeconfig

Locate line “server: https://127.0.0.1:8443“, then replace with:

server: https://serverip:8443

3. Then start cluster:

$ oc cluster up

You should see an OpenShift Origin window with Username and Password forms, similar to this one:

Login with:

Username: developer
Password: developer

You should see a dashboard similar to below.

A Project can be created from the web console.