ARG DEBIAN_RELEASE=bullseye
ARG LICENSE=''
FROM docker.io/debian:$DEBIAN_RELEASE-slim
ARG DEBIAN_RELEASE
ENV DEBIAN_FRONTEND noninteractive
ENV LICENSE=${LICENSE}
RUN true && \
	apt update && \
    apt upgrade -y &&\
	apt install -y gnupg ca-certificates curl socat && \
	curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg && \
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/  $DEBIAN_RELEASE main" | tee /etc/apt/sources.list.d/cloudflare-client.list && \
	apt update && \
	apt install cloudflare-warp -y --no-install-recommends && \
	apt clean -y && \
	rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /

RUN  chmod +x /entrypoint.sh

EXPOSE 40000/tcp
ENTRYPOINT [ "/entrypoint.sh" ]
