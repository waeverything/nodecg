FROM node:10

WORKDIR /home/container/nodecg

RUN adduser -D -h /home/container container && \
    npm install -g nodecg-cli && \
    mkdir cfg && mkdir bundles && mkdir logs && mkdir db && \
    chown -R container:container /home/container/nodecg

USER nodecg

# Copy package.json and package-lock.json
COPY --chown=container:container package*.json /home/container/nodecg

# Install dependencies
RUN npm ci --production

# Copy NodeCG (just the files we need)
COPY --chown=container:container . /home/container/nodecg

# Define directories that should be persisted in a volume
VOLUME /home/container/nodecgcfg /home/container/nodecgbundles /home/container/nodecglogs /home/container/nodecgdb
# Define ports that should be used to communicate
EXPOSE {{server.build.default.port}}/tcp

# Define command to run NodeCg
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
