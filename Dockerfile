FROM alpine:latest
MAINTAINER zacharias <szacharias126@gmail.com>

ENV HUGO_VERSION=0.55.6
ENV GOSU_VERSION=1.10
ENV DUMB_VERSION=1.2.0

RUN apk add --no-cache --update wget \
 && wget --no-check-certificate https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
 && tar zxvf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
 && mv hugo /usr/local/bin/hugo \ 
 && chmod +x /usr/local/bin/hugo

RUN adduser hugo -H -D -s /bin/false

ADD https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 /usr/local/bin/gosu
ADD https://github.com/Yelp/dumb-init/releases/download/v${DUMB_VERSION}/dumb-init_${DUMB_VERSION}_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/gosu \
 && chmod +x /usr/local/bin/dumb-init

VOLUME /data
WORKDIR /data
EXPOSE 1313
ENTRYPOINT ["/usr/local/bin/dumb-init", "/usr/local/bin/gosu", "hugo", "/usr/local/bin/hugo"]

