FROM python:3.9-alpine

# upgrade pip to latest version and install mkdocs
RUN apt-get update \
    && pip install --upgrade pip \
    && pip install mkdocs

ENTRYPOINT [ "mkdocs" ]