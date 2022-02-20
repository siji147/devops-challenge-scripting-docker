FROM python:3.9

# install mkdocs
RUN pip install mkdocs

# create scripts and root directories on the container
RUN mkdir -p /home/mkdocs-image/scripts \
    && mkdir -p /home/mkdocs-image/root

# copy the mkdockerize wrapper script to the scripts directory created above
COPY ./mkdockerize.sh /home/mkdocs-image/scripts

# add execute permissions on the wrapper script
RUN chmod +x /home/mkdocs-image/scripts/mkdockerize.sh

# set working directory to the newly created root folder
# the root folder will contain all mkdocs resources
WORKDIR /home/mkdocs-image/root

# set the wrapper script as entrypoint and pass command line argument in the script
ENTRYPOINT ["/home/mkdocs-image/scripts/mkdockerize.sh"]
