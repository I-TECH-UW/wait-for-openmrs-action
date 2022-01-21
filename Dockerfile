FROM bash:latest

COPY entrypoint.sh /entrypoint.sh

RUN apk add --update-cache \
    curl \
  && rm -rf /var/cache/apk/*
  
ENTRYPOINT ["/entrypoint.sh"]