FROM alpine:latest

RUN apk update && apk add wget bash --no-cache
COPY speed-test.sh /speed-test.sh
ENTRYPOINT ["bash","./speed-test.sh"]
