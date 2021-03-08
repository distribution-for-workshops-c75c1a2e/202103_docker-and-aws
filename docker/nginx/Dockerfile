#######################################################################
###-*-Build an original nginx image from an official nginx image.-*-###
#######################################################################
FROM nginx:latest

# Install packages and clean cache & set TimeZone.
RUN apt update \
 && apt upgrade -y \
 && apt install -y --no-install-recommends \
        iproute2 \
        procps \
        tree \
        vim \
 && apt autoremove \
 && apt -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime


# Copy index.html from host machine.
COPY setup/ /setup
RUN chmod 755 /setup/entrypoint.sh \
 && cp /setup/index.html /usr/share/nginx/html/index.html

# Create a user and a group; "docker", and set for the "docker" to execute nginx on port 80 (a well-known port).
RUN groupadd -g 150 docker \
 && useradd -g docker -M -s /bin/bash -u 150 docker \
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
#ENTRYPOINT ["sudo", "/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
