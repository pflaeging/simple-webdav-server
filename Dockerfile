FROM httpd:bullseye

# set some metadata
LABEL summary="Apache https webdav server (apache bullseye version)" \
      maintainer="Peter Pflaeging <peter@pflaeging.net>" \
      io.openshift.expose-services="8080:http"

USER 0

# make /etc/passwd for group 0 writable
RUN chmod g=u /etc/passwd

# setup APP dir
ENV HOME=/usr/local/apache2

RUN mkdir -p /data && chmod -R g=u $HOME /data
WORKDIR $HOME

# replace httpd.conf
ADD httpd.conf $HOME/conf/httpd.conf
ADD dav-index.html $HOME/htdocs/

# copy entrypoint
ADD docker-entrypoint.sh $HOME/bin/
RUN chmod 755 $HOME/bin/docker-entrypoint.sh

# setups
VOLUME /data
EXPOSE 8080

USER 11177:0
# entrypoint makes setups
ENTRYPOINT ["/usr/local/apache2/bin/docker-entrypoint.sh"]
# cmd sets default command
CMD ["httpd-foreground"]
