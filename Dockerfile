FROM node:10



USER root

RUN useradd -ms /bin/bash -u 1001 container && \
    npm install -g nodecg-cli

WORKDIR /home/container/

RUN mkdir cfg && mkdir bundles && mkdir logs && mkdir db 

# Copy package.json and package-lock.json
COPY --chown=container:container package*.json /home/container/

#RUN chown -R container:container /home/container/.npm

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container/

# Install dependencies
RUN npm ci --production

# Copy NodeCG (just the files we need)
COPY --chown=container:container . /home/container/

# Define directories that should be persisted in a volume
VOLUME /home/container/cfg /home/container/bundles /home/container/logs /home/container/db


# Define command to run NodeCg
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
