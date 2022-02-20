FROM python:3.9

# install mkdocs
RUN pip install mkdocs

RUN mkdir -p /home/docker-image-scripts

COPY ./docker-image-scripts /home/docker-image-scripts

WORKDIR /home/docker-image-scripts

ENTRYPOINT ["/bin/bash"]