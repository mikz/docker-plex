# Plex in Docker

Create two dockers. One will just have a volume with configuration and the other will actually run.

```shell
docker create --net=host --restart=no --name plex-config  quay.io/mikz/plex
docker create --net=host --restart=unless-stopped --name plex --volumes-from=plex-config --volume /mnt/storage:/mnt/storage quay.io/mikz/plex
```

Why? Because you can easily upgrade.


Now start the docker with configuration, so you can go through the configuration wizard.

```shell
docker start plex-config
```

```shell
docker stop plex-config
docker start plex
```

Voila! Now you can set up your nginx to forward to the running plex.




