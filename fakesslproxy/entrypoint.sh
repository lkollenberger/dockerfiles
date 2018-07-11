#!/bin/bash

set -xeuo pipefail

SERVER_NAME=${SERVER_NAME:-localhost}
BACKEND_PORT=${BACKEND_PORT:-8080}
LISTEN_PORT=${LISTEN_PORT:-443}
CERT=${CERT:-/selfssl/cert.pem}
KEY=${KEY:-/selfssl/cert.key}

if [ -z "${BACKEND_HOST}" ]; then
	echo '$BACKEND_HOST missing, this will not work!'
	exit 1
fi

mkdir -p /selfssl
openssl req -x509 -sha256 -newkey rsa:2048 -keyout /selfssl/cert.key -out /selfssl/cert.pem -days 1024 -nodes -subj "/CN=${SERVER_NAME}"

cat << EOF > /etc/nginx/conf.d/default.conf
server {
	listen       ${LISTEN_PORT} ssl;
    server_name  ${SERVER_NAME};


    location / {
		proxy_pass http://${BACKEND_HOST}:${BACKEND_PORT};
    }

	ssl_certificate ${CERT};
	ssl_certificate_key ${KEY};

}
EOF

nginx -g 'daemon off;'
