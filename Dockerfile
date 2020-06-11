FROM node:10



USER root

RUN useradd -ms /bin/bash -u 1001 container && \
    npm install -g nodecg-cli

WORKDIR /home/container/

#RUN chown -R container:container /home/container/.npm

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container/

# Install dependencies
RUN nodecg setup



# Define command to run NodeCg
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
