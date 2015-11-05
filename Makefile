RUN = docker run -p 32400:32400

build:
	docker build -t plex .
bash:
	$(RUN) --rm -it -u root plex bash

start:
	$(RUN) plex

test:
	$(RUN) --rm -it plex /usr/lib/plexmediaserver/Plex\ Media\ Server --version
