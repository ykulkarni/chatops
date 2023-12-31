FROM node:18-alpine

RUN npm install -g coffee-script@1.12.7
RUN npm install -g yo generator-hubot

# Create hubot user
RUN	adduser -h /hubot -s /bin/bash -D hubot

# Log in as hubot user and change directory
USER	hubot
WORKDIR /hubot

# Install hubot
RUN yo hubot --owner="ykulkarni@diameterhealth.com" --name="releasebot" --description="Release a Product" --adapter="slack" --defaults 

RUN npm uninstall hubot-heroku-keepalive --save

ADD scripts/releasebot.coffee /hubot/scripts/
ADD external-scripts.json /hubot/
ADD package.json package.json

RUN npm install

# And go
CMD ["/bin/sh", "-c", "bin/hubot --adapter slack"]