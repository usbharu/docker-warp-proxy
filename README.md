# docker-warp-proxy

Docker image to run Cloudflare Warp in proxy mode. Image is rebuilt and updated every day.

## Usage

```
docker run -d -p 40000:40000 --restart unless-stopped seiry/cloudflare-warp-proxy
```

SOCKS5 proxy server will be listening at port 40000.
