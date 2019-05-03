FROM nginx:1.14-alpine

MAINTAINER Jens Hassler <j.hassler@iwf.ch>

# Argument variables
ARG GIT_COMMIT
ARG GIT_BRANCH=releases/nginx-1.14
ARG GIT_DIRTY=undefined
ARG BUILD_CREATOR
ARG BUILD_NUMBER
ARG TIMEZONE=Europe/Zurich

ENV DEBIAN_FRONTEND=noninteractive

# This one defines which config file is linked into sites.d (APP_FRAMEWORK.conf)
ENV APP_FRAMEWORK="symfony"
ENV RUNTIME_ENVIRONMENT="local"
ENV DOCUMENT_ROOT="/app/web"


# Add labels
LABEL io.web-solutions.git-branch=$GIT_BRANCH \
      io.web-solutions.git-commit=$GIT_COMMIT \
      io.web-solutions.git-is-dirty=$GIT_DIRTY \
      io.web-solutions.build-creator=$BUILD_CREATOR \
      io.web-solutions.build-number=$BUILD_NUMBER

# COPY our config
COPY ./assets/ /
RUN chmod +x /usr/local/bin/webstartup.sh

# Set time zone
RUN ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

# pre-create the document root
RUN mkdir -p ${DOCUMENT_ROOT}

ENTRYPOINT ["/usr/local/bin/webstartup.sh"]
CMD ["nginx", "-g", "daemon off;", "-c", "/data/conf/nginx/nginx.conf"]
