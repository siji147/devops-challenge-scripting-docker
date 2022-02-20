# woven-planet-challenge

### Introduction

---

This challenge is about using Docker to encapsulate a tool called Mkdocs ([http://www.mkdocs.org/](http://www.mkdocs.org/)) to produce and serve a website in order to avoid installing Mkdocs locally.

### Building the Image

---

The Dockerfile in the root of the zipped file contains well-commented steps taken during the mkdocs image build.

The base image for the mkdocs image is `python:3.9`. I tried to use `python:3.9-alpine` to make the image smaller in size but the alpine version did not have `/bin/bash` pre-installed.

To create an image from the Dockerfile, run this command from the root directory of the zipped file:

```bash
docker build -t mkdocs .
```

This will build the image as `mkdocs` and assign it the tag `latest`.You can also give the image a custom name or tag if you want by running the command:

```bash
docker build -t <image-name>:<tag> .
```

### Running the Container

---

To ensure that the container can read, produce and serve the mkdocs files on the host machine, the path to the root directory of the valid mkdocs resources on the host must be mounted as a volume and passed as an argument of the `docker run` command. That way, changes made on the host will be reflected in the container and vice versa.

The path to the volume on the container is defined as `/home/mkdocs-image/root`. This is a fixed path and should not be changed.

- **Produce:**
The `produce` command will build the mkdocs resources and zip the resulting static web assets in a `.tar.gz` format.
The command to run is:
    
    ```bash
    docker run -v <path-to-mkdocs-directory-on-local>:/home/mkdocs-image/root mkdocs produce
    ```
    
    e.g.
    
    ```bash
    docker run -v ~/mkdocs-demo:/home/mkdocs-image/root mkdocs produce
    ```
    
- **Serve:**
The `serve` command will extract the `.tar.gz` files containing the static web assets produced by the `produce` command and then serve it on port 8000
    
    ```bash
    docker run --net="host" -v <path-to-mkdocs-directory-on-local>:/home/mkdocs-image/root mkdocs serve
    ```
    
    e.g.
    
    ```bash
    docker run --net="host" -v ~/mkdocs-demo:/home/mkdocs-image/root mkdocs serve
    ```
    
    **The website will be reachable on the host machine at localhost:8000.**
    

### Slight Deviation from the Problem Statement

---

The problem statement under the section titled “Running the website” required that the command below was used to run the website.

```bash
docker run -p 8000:8000 <arguments> <the-docker-image-name> serve
```

The challenge with this was that even after binding the host port to container port as descibed above, the container was running but it was unreachable from the host machine.

The workaround to this was to add a network flag `--net=”hosts”` and remove the publish ports `-p 8000:8000` like below:

```bash
docker run --net="host" -v <path-to-mkdocs-directory-on-local>:/home/mkdocs-image/root mkdocs serve
```

Using the `host` network, the container’s network stack is not isolated from the Docker host and the service running on the container will be reachable from the host. Since the container will run on port 8000, the host will also be able to access the webpage on `localhost:8000`.