#############################################################################
###-*-Build an original postgres image from an official postgres image.-*-###
#############################################################################
ARG DB_BASE_IMAGE
FROM ${DB_BASE_IMAGE}


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
 && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
 #&& cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
 #&& apk del tzdata


##############################################
###-*-Individual settings for each image-*-###
##############################################
# Set args using in the Dockerfile (individual).
ARG DB_USER

# Copy "setup/" from host machine,
# and set "/setup/entrypoint.sh" as a part of the init process.
COPY setup/ /setup
RUN cp /setup/entrypoint.sh /docker-entrypoint-initdb.d/

# Change a user from "root" to ${DB_USER},
# who execute any "RUN", "CMD", and "ENTRYPOINT" instructions that follow "USER."
USER ${DB_USER}
