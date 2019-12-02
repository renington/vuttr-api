FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libssl-dev
RUN mkdir /app
WORKDIR /app

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 4.4.7

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v

RUN npm install -g aglio

COPY app/Gemfile /app/Gemfile
COPY app/Gemfile.lock /app/Gemfile.lock

RUN bundle install
COPY app /app