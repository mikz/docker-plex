RUN = docker run -p 32400:32400

build:
	docker build -t plex .
bash:
	$(RUN) -rm -it plex bash

start:
	$(RUN) plex
