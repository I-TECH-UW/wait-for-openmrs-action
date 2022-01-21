FROM bash:latest

COPY entrypoint.sh /entrypoint.sh

ENV TARGET_URL="http://isanteplus:8080/openmrs"
ENV INTERVAL=10
ENV TIMEOUT=100

RUN apk add --update-cache \
    curl \
  && rm -rf /var/cache/apk/*
  
ENTRYPOINT ["/entrypoint.sh"]
CMD ["${TARGET_URL}", "${INTERVAL}", "${TIMEOUT}"]