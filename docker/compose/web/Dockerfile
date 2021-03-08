#######################################################################
###-*-Build an original nginx image from an official nginx image.-*-###
#######################################################################
ARG WEB_BASE_IMAGE
FROM ${WEB_BASE_IMAGE}


#################################################
###-*-Common settings for almost all images-*-###
#################################################
# Set args using in the Dockerfile (common).
ARG PACKAGES
ARG TIMEZONE

# Install packages and clean cache & set TimeZone.
RUN apt update \
 && apt upgrade -y \
 && apt install -y --no-install-recommends ${PACKAGES} \
 && apt autoremove \
 && apt -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime


##############################################
###-*-Individual settings for each image-*-###
##############################################
# Set args using in the Dockerfile (individual).
ARG WEB_USER
ARG WEB_GROUP
ARG UID
ARG GID
ARG WEB_PORT
ARG AP_CONTAINER
ARG AP_PORT

# Copy "setup/" from host machine,
# and replace placeholders for the above args in templates to create .conf files.
COPY setup/ /setup
RUN chmod 755 /setup/entrypoint.sh \
 && envsubst '$$AP_CONTAINER $$AP_PORT'< /setup/nginx.conf.template > /etc/nginx/nginx.conf \
 && envsubst '$$WEB_PORT'< /setup/APserver.conf.template > /etc/nginx/conf.d/APserver.conf

# Create a user and a group, and set for the user/group to execute nginx on port 80 (a well-known port).
RUN groupadd -g ${GID} ${WEB_GROUP} \
 && useradd -g ${WEB_GROUP} -M -s /bin/bash -u ${UID} ${WEB_USER} \
 && touch /var/run/nginx.pid \
 && chown -R ${WEB_USER}:${WEB_GROUP} \
          /usr/share/nginx/html/ \
          /var/cache/nginx/ \
          /var/log/nginx/ \
          /var/run/nginx.pid

# Change a user from "root" to ${WEB_USER},
# who execute any "RUN", "CMD", and "ENTRYPOINT" instructions that follow "USER."
USER ${WEB_USER}

# Set "/setup/entrypoint.sh" as the init process (-> form: exec /setup/ent...).
ENTRYPOINT ["/setup/entrypoint.sh"]
