# Simple webdav server

This is a WebDav server primary for OpenShift / OKD / Kubernetes.

The primary use is to share keepass files secure between devops teams.

The system consist of a standard apache container and a minimal configuration for WebDav.

Users are created in a local htpasswd file inside the pvc which stores the files (`/data/config/users.password`).

You can upload static html files to the servers htdocs directory `/data/htdocs/`
## build

`oc apply -k kustomize/build/`

## deploy

`oc apply -k kustomize/template`

## create user / modify password

Login to your cluster and switch to the correct namespace. Then:

`oc exec -ti  $(oc get pod -l app=simple-webdav-server -o name | head -1) -- htpasswd /data/config/users.password username`

or use 

`./htpasswd.sh`

---
Peter Pfläging <<peter@pflaeging.net>>
