FROM node:lts

# Create app directory
WORKDIR /usr/src/bff

RUN apt-get update && apt-get install -y wget

# Clean dependencies
RUN rm -rf node_modules
RUN rm -rf package-lock.json
RUN rm -rf yarn.lock

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY package*.json /
COPY . ./

RUN yarn install

EXPOSE 3333
CMD ["yarn","start:prod"]