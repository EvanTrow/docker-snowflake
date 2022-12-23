# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-20.04

# Install termius
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget libgtk-3-0 libnotify4 libnss3 libxss1 xdg-utils libatspi2.0-0 libsecret-1-0 openjdk-11-jre

RUN DEBIAN_FRONTEND=noninteractive wget https://github.com/subhra74/snowflake/releases/download/v1.0.4/snowflake-1.0.4-setup-amd64.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i snowflake-1.0.4-setup-amd64.deb && apt-get clean

# Copy the start script.
COPY startapp.sh /startapp.sh

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://gitlab.com/uploads/-/system/project/avatar/15815324/snowflake.png && \
    install_app_icon.sh "$APP_ICON_URL"

RUN DEBIAN_FRONTEND=noninteractive cat /startapp.sh

# Set the name of the application.
ENV APP_NAME="Snowflake SSH"