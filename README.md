btsync-docker-volume
=========

A Docker image you can use to quickly sync folders using BTSync. (http://www.bittorrent.com/sync)

Local folders, or folders from Docker volumes.

# How to use

## Pull the Docker image

``` bash
docker pull aduermael/btsync-volume
```

If Docker is not installed: https://docs.docker.com/installation/

## Run the container

#### IF you already have a BTSync secret key

**SECRET_KEY**: A secret key associated with a synchronized folder. You can sync a folder using a BitTorrent Sync client: http://www.bittorrent.com/sync. (you can use a read-only key)

- Sync a folder from a Docker Volume:

    ``` bash
    docker run -d --volumes-from VOLUME_NAME -p 55555:55555 aduermael/btsync-volume DIR_PATH SECRET_KEY
    ```
    **VOLUME_NAME**: The name of your Docker volume (the one containing the directory you want to sync). You can use the container ID as well.

    **DIR_PATH**: The path to the directory.
    
- Sync any local folder:

    ``` bash
    docker run -d -v PATH_TO_FOLDER:CONTAINER_PATH_TO_FOLDER -p 55555:55555 aduermael/btsync-volume CONTAINER_PATH_TO_FOLDER SECRET_KEY
    ```
    
    **PATH_TO_FOLDER**: Path to your local folder.
    
    **CONTAINER_PATH_TO_FOLDER**: The path where you would like to mount your local folder, inside the container.

#### IF you want to generate a new secret key

_Coming soon_