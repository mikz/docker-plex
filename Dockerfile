FROM debian:stable
ARG PLEX_VERSION=1.15.4.994-107756f7e

RUN set -x; \
 apt-get -y update && apt-get -y upgrade \
 && apt-get -y install wget \
 && wget -q https://downloads.plex.tv/plex-media-server-new/${PLEX_VERSION}/debian/plexmediaserver_${PLEX_VERSION}_amd64.deb \
 && dpkg --install plexmediaserver_${PLEX_VERSION}_amd64.deb \
 && apt-get -y remove wget \
 && apt-get -y autoremove --purge \
 && apt-get -y clean \
 && rm -r /var/lib/apt/lists plexmediaserver_*.deb \
 && sed -i 's:(\(.\+;\)\(.\+\)):\1 exec\2:' /usr/sbin/start_pms

USER plex

ENV LD_LIBRARY_PATH=/usr/lib/plexmediaserver
VOLUME /var/lib/plexmediaserver/
WORKDIR /var/lib/plexmediaserver/

EXPOSE 32400

# apt-get update -y && apt-get -y install xmlstarlet
# xmlstarlet ed --inplace -i '/Preferences' -t attr -n allowedNetworks -v '192.168.0.0/255.255.0.0' Preferences.xml

CMD ["/usr/sbin/start_pms"]
