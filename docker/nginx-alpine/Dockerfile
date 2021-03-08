#######################################################################
###-*-Build an original nginx image from an official nginx image.-*-###
#######################################################################
FROM nginx:alpine

# Install packages without cache & set TimeZone.
RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        iproute2 \
        libcap \
        procps \
        tree \
        tzdata \
        vim \
 && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apk del tzdata


# Copy index.html from host machine.
COPY setup/ /setup
RUN chmod 755 /setup/entrypoint.sh \
 && cp /setup/index.html /usr/share/nginx/html/index.html

# Create a user and a group; "docker", and set for the "docker" to execute nginx on port 80 (a well-known port).
RUN addgroup -g 150 docker \
 && adduser --disabled-password \
            --ingroup docker \
            --no-create-home \
            -s /bin/ash \
            --uid 150 \
            docker \
 && touch /var/run/nginx.pid \
 && chown -R docker:docker \
          /usr/share/nginx/html/ \
          /var/cache/nginx/ \
          /var/log/nginx/ \
          /var/run/nginx.pid

# Change a user from "root" to "docker",
# who execute any "RUN", "CMD", and "ENTRYPOINT" instructions that follow "USER."
USER docker

# Set "/setup/entrypoint.sh" as the init process (-> form: exec /setup/ent...).
ENTRYPOINT ["/setup/entrypoint.sh"]
