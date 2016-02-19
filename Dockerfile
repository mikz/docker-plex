FROM debian:jessie

ENV PLEX_VERSION=0.9.15.3.1674-f46e7e6

RUN apt-get -y update \
 && apt-get -y install wget \
 && wget -q https://downloads.plex.tv/plex-media-server/${PLEX_VERSION}/plexmediaserver_${PLEX_VERSION}_amd64.deb \
 && dpkg --install plexmediaserver_${PLEX_VERSION}_amd64.deb \
 && apt-get -y remove wget \
 && apt-get -y autoremove \
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
