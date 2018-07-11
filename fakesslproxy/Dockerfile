FROM nginx:1.15.1
MAINTAINER Leandro Kollenberger <docker@kollenberger.me>

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y openssl && rm -rf /var/lib/apt/lists/ /var/cache/apt/archives/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh
