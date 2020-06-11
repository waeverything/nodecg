#!/bin/bash
cd /home/container

# Output used versions of Node and npm
node -v
npm version

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Run the server
nodecg start