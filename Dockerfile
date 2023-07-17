FROM node:18-alpine

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

# Create hubot user
RUN	adduser -h /hubot -s /bin/bash -D hubot

# Log in as hubot user and change directory
USER	hubot
WORKDIR /hubot

# Install hubot
RUN yo hubot --owner="ykulkarni@diameterhealth.com" --name="releasebot" --description="Release a Product" --adapter="shell" --defaults 

# Some adapters / scripts
RUN npm install hubot-slack --save && npm install

ADD scripts/releasebot.coffee /hubot/scripts/

# And go
CMD ["/bin/sh", "-c", "bin/hubot --adapter shell"]