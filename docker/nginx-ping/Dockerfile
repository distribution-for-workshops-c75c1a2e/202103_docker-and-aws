##########################################################################
###-*-Build an original nginx image from an official nginx image.   -*-###
###-*-Change ENTRYPOINT to "ping" or "ping -c 1."                   -*-###
###-*-If "ping -c 1" is executed, containers get exited in a moment.-*-###
##########################################################################
FROM nginx:alpine

RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        iproute2 \
        procps \
        tree \
        tzdata \
        vim \
 && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apk del tzdata


# Set "ping 127.0.0.1" as the init process (-> form: exec ping...).
ENTRYPOINT ["ping", "127.0.0.1"]
#ENTRYPOINT ["ping", "-c", "1", "127.0.0.1"]
#ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
