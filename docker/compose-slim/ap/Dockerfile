#######################################################################################
###-*-Build an original python (django) image from an official slim python image.-*-###
#######################################################################################
ARG AP_BASE_IMAGE
FROM ${AP_BASE_IMAGE}


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
ARG AP_USER
ARG AP_GROUP
ARG UID
ARG GID
ARG AP_VOLUME

# Setup python environment.
COPY setup/ /setup
RUN chmod 755 /setup/entrypoint.sh \
 && pip install --upgrade pip \
 && pip install --no-cache-dir -r /setup/requirements.txt

# Create a user and a group, and change owner of "${AP_VOLUME}" and "/var/log/gunicorn" for development and gunicorn execution.
RUN groupadd -g ${GID} ${AP_GROUP} \
 && useradd -g ${AP_GROUP} \
            -m \
            -s /bin/bash \
            -u ${UID} \
            ${AP_USER} \
 && mkdir -p ${AP_VOLUME} /var/log/gunicorn \
 && chown ${AP_USER}:${AP_GROUP} ${AP_VOLUME} \
 && chown ${AP_USER}:${AP_GROUP} /var/log/gunicorn

# Change a user from "root" to ${AP_USER} and a workdir from "/" to ${AP_VOLUME},
# who execute any "RUN", "CMD", and "ENTRYPOINT" instructions that follow "USER."
USER ${AP_USER}
WORKDIR ${AP_VOLUME}

# Set "/setup/entrypoint.sh" as the init process (-> form: exec /setup/ent...).
ENTRYPOINT ["/setup/entrypoint.sh"]
