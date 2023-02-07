#! /bin/sh
set -e

# make passwd entry for arbitrary running user (openshift / kubernetes)
if ! whoami 2> /dev/null; then
    if [ -w /etc/passwd ]; then
        echo "${USER_NAME:-runner}:x:$(id -u):0:${USER_NAME:-runner} user:$HOME:/sbin/nologin" >> /etc/passwd
    fi
fi

mkdir -p /data/config/ /data/content/ /data/htdocs/ 

if [ -f /data/htdocs/index.html ]; then
    echo "Assuming PV has data"
else
    cp /usr/local/apache2/htdocs/dav-index.html /data/htdocs/index.html
fi

if [ -f /data/config/users.password ]; then
    echo "Assuming users are present"
else
    touch /data/config/users.password
fi


exec "$@"