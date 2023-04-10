#!/bin/bash

(
while ! warp-cli --accept-tos register; do
	sleep 1
	>&2 echo "Awaiting warp-svc become online..."
done
warp-cli --accept-tos set-mode proxy
warp-cli --accept-tos set-proxy-port 40001
warp-cli --accept-tos connect
socat TCP-LISTEN:40000,fork TCP:localhost:40001  # socat is used to redirect traffic from 40000 to 40001
) &

exec warp-svc
warp-cli enable-always-on
