FROM golang:alpine as builder

RUN apk --no-cache add bash make openssl
COPY . /go/src/github.com/bakins/php-fpm-exporter
RUN cd /go/src/github.com/bakins/php-fpm-exporter && ./script/build

FROM ubuntu:20.04
RUN apt-get update -y
COPY --from=builder /go/src/github.com/bakins/php-fpm-exporter/php-fpm-exporter.linux.amd64 /php-fpm-exporter

ENTRYPOINT [ "/php-fpm-exporter" ]
