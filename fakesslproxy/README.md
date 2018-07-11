## Fake SSL Proxy

### What's this?

Ever wanted a simple way of exposing some HTTP thing over HTTPS, just to test it, with a self-signed certificate? This is it.

### Example

Run a container:

```
docker run --name=http --rm -d nginx
```

Expose it over HTTPS with a fake cert:
```
docker run --name=https --rm -d -e SERVER_NAME=thisisfake.com -e BACKEND_HOST=http -e BACKEND_PORT=80 -p 443:443 --link http lkollenberger/fakesslproxy
```

### Options

All of these are set as environment variables:

`BACKEND_HOST`: mandatory, where to forward the request.
`BACKEND_PORT`: defaults to `8080`.
`SERVER_NAME`: `CN` used in the self-signed cert, defaults to `localhost`.
`LISTEN_PORT`: defaults to `443`.
`CERT` and `KEY`: path to certificate and key, in case you wanna use your own via a mounted volume or something.
