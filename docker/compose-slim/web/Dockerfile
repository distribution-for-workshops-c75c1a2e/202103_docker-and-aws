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

# Install packages without cache & set TimeZone.
RUN apk update \
 && apk upgrade \
 && apk add --no-cache ${PACKAGES} \
 && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
 && apk del tzdata


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
RUN addgroup -g ${GID} ${WEB_GROUP} \
 && adduser --disabled-password \
            --ingroup ${WEB_GROUP} \
            --no-create-home \
            -s /bin/ash \
            --uid ${UID} \
            ${WEB_USER} \
 && setcap CAP_NET_BIND_SERVICE=p /usr/sbin/nginx \
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
