#! /bin/sh
set -e

# make passwd entry for arbitrary running user (openshift / kubernetes)
if ! whoami 2> /dev/null; then
    if [ -w /etc/passwd ]; then
        echo "${USER_NAME:-runner}:x:$(id -u):0:${USER_NAME:-runner} user:$HOME:/sbin/nologin" >> /etc/passwd
    fi
fi

mkdir -p /data/config/ /data/content/public/ /data/htdocs/ /data/var/

if [ -f /data/htdocs/index.html ]; then
    echo "Assuming PV has data"
else
    # are we on the original apache container or on ubi-minimal?
    if [ -f /usr/local/apache2/htdocs/dav-index.html ]; then
        cp /usr/local/apache2/htdocs/dav-index.html /data/htdocs/index.html
    else
        cp /etc/httpd/htdocs/dav-index.html /data/htdocs/index.html
fi

if [ -f /data/config/users.password ]; then
    echo "Assuming users are present"
else
    touch /data/config/users.password
fi


exec "$@"