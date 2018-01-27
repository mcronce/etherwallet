FROM node:alpine

RUN apk add --no-cache libnotify

ADD . /app
WORKDIR /app

RUN \
	apk add --no-cache nodejs-npm make g++ bash python && \
	npm install && \
	npm cache clear --force && \
	apk del --no-cache nodejs-npm make g++ bash python

RUN \
	apk add --no-cache nodejs-npm && \
	npm install -g gulp-cli && \
	gulp prep && \
	npm run dist && \
	npm uninstall -g gulp-cli && \
	npm cache clear --force && \
	apk del --no-cache nodejs-npm

