---
layout: page
title: Docker tips and tricks
description: A collection of tips and trick for docker to make life easier
tags: [docker]
---

Here is a collection of tips and tricks for [Docker](https://www.docker.com/).



## Docker bin scripts
I am a big fan of bin scripts. This includes when working with docker. I create bin scripts for all the regular operations I do. This includes:

### Docker compose
Note: Most often these scripts use docker-compose under the hood. They are called docker, but use compose if needed.

### Development scripts
- `bin/dev/docker/build`
Builds or rebuilds the image

- `bin/dev/docker/clean`
Destroys containers, images and build cache for the project. Works much like `docker compose down`, but is more thorough.

- `bin/dev/docker/start`
Starts the container

- `bin/dev/docker/stop`
Stops the container

- `bin/dev/docker/exec`
Executes in the container

- `bin/dev/docker/prepare`
Run any steps required to "prepare" the container for start. Most often this means recreating and migrating the database.


### Scripts if project uses a docker base image
- `bin/dev/docker/base_image/build`
Builds the base image for the container.

- `bin/dev/docker/base_image/push`
Pushes the base image for the container.

## Debugging a failed Docker container

### On local development machine
The simplest way to debug a failed docker container is to simply do `docker compose up` and see what went wrong.

### On servers - script to print logs on error
In cases where you cannpt simply do `docker compose up`, use this script to print the docker compose logs if the container crashed:

It will look for a matching "my-container-web" name with `docker ps`, and print compose logs if one cannot be found, meaning the container crashed. 
```
container_name="my-container-web"
docker ps -f name=$container_name | grep -w "$container_name" || docker-compose logs
```
