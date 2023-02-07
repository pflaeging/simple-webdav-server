# Simple webdav server

## build

`oc apply -k kustomize/build/`

## deploy

`oc apply -k kustomize/template`

## create user / modify password

`oc exec -ti  $(oc get pod -l app=simple-webdav-server -o name | head -1) -- htpasswd /data/config/users.password username`

---
Peter Pfläging <<peter@pflaeging.net>>
