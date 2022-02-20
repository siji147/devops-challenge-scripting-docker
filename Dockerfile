FROM python:3.9

# install mkdocs
RUN pip install mkdocs

RUN mkdir -p /home/mkdocs-image/scripts \
    && mkdir -p /home/mkdocs-image/root

COPY ./mkdockerize.sh /home/mkdocs-image/scripts

RUN chmod +x /home/mkdocs-image/scripts/mkdockerize.sh

WORKDIR /home/mkdocs-image/root

# EXPOSE 8000

# ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["/home/mkdocs-image/scripts/mkdockerize.sh"]
