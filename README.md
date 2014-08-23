btsync-docker-volume
=========

A Docker container you can use to quickly access Docker volumes using BTSync. (http://www.bittorrent.com/sync)

### How to use

- Pull the Docker image

```sh
docker pull aduermael/btsync-volume
```
- Run the container

```sh
docker run -d --volumes-from VOLUME_NAME -p 55555:55555 aduermael/btsync-volume DIR_PATH SECRET_KEY
```
__VOLUME_NAME__: The name of your Docker volume (the one containing the directory you want to sync). You can use the container ID as well.

__DIR_PATH__: The path to the directory.

__SECRET_KEY__: A secret key associated with a btsynced folder. You can sync a folder using a BitTorrent Sync client: http://www.bittorrent.com/sync