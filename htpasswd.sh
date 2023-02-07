#! /bin/sh
oc exec -ti  $(oc get pod -l app=simple-webdav-server -o name | head -1) -- htpasswd /data/config/users.password $*