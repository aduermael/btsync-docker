Dockerized BTSync
=========

A Docker image you can use to quickly sync folders using BTSync. (http://www.bittorrent.com/sync)


# How to use

## Pull the Docker image

``` bash
docker pull aduermael/btsync
```

If Docker is not installed: https://docs.docker.com/installation/

## Run the container

``` bash
docker run -t -i -d -p 55555:55555 aduermael/btsync
```

If you want to sync folders from your host or Docker volumes, be sure to mount them when running the container. Unfortunately this can't be done later (yet).

- Mount folders from your own host: 

    ``` bash
    docker run -t -i -d -p 55555:55555 -v [host-dir]:[container-dir] aduermael/btsync
    ```
    This will mount the host directory, **[host-dir]** (path), into the container at **[container-dir]** (path).

- Mount folders from Docker volumes

    ``` bash
    docker run -t -i -d -p 55555:55555 --volumes-from [container-name] aduermael/btsync
    ```
    This will mount all volumes (folders) from the given container ( **[container-name]** )
    

#### IF you already have a BTSync secret key

If you already have a secret key you can quickly synchronize your folder when running the container:

``` bash
docker run -t -i -d -p 55555:55555 aduermael/btsync [container-dir][secret-key]
```

**[container-dir]**: Absolute path to the directory (inside the container).

**[secret-key]**: A secret key associated with a synchronized folder. You can sync a folder using a BitTorrent Sync client: http://www.bittorrent.com/sync. (you can use a read-only key)


## Sync / disconnect folders

Use **attach** command to interact with your btsync running container.

``` bash
docker attach [container-name]
```

- When running the container, you can assign a name with **--name** option:

    ``` bash
    docker run -t -i -d -p 55555:55555 --name btsync aduermael/btsync
    ```

- If you did not assign a name, use **docker ps** the one that was generated:

    ``` bash
    $ docker ps
    CONTAINER ID        IMAGE                     COMMAND                CREATED             STATUS              PORTS                      NAMES
    aef963c15535        aduermael/btsync:latest   /bin/bash ./start.sh   6 minutes ago       Up 6 minutes        0.0.0.0:55555->55555/tcp   btsync
    ```

#### Commands

When you attach to this container, you can use different commands to sync or disconnect folders.

``` bash
Commands: {folders|add-folder|remove-folder|detach|clear|help|ls|cd|mkdir|rm}
>
```

- **folders**
    List folders and respective BTSync keys.
    
- **add-folder** [dir] [btsync-key]*
    - **[dir]** folder's absolute path
    - **[btsync-key]* (optional)** Will be generated if not provided
    
    ``` bash
    > add-folder /SYNC/test
Added /SYNC/test
      secret: AO5ACOUNYHDHI5PE4NHLRMAWAQPMNV7T
      read-only: RIJK3SFTY2K73XNDDAEF5BNWS4BCCSI5
    ```
- **remove-folder** [dir]
    - **[dir]** folder's absolute path

    ``` bash
    > remove-folder /SYNC/test
Removed /SYNC/test
    ```

#### Detach

To detach from the container, use the escape sequence **Ctrl-p + Ctrl-q**