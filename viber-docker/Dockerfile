# Viber for Franz plugin - Based on docker ubuntu 16.04 LTS
FROM ubuntu:bionic
MAINTAINER DN "david@nedved.com.au"

# Configure Environment Variables
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_ARG0=/sbin/entrypoint.sh \
    VNC_GEOMETRY=800x600 \
    VNC_PASSWD='pass' \
    USER_PASSWD='' \
    DEBIAN_FRONTEND=noninteractive

RUN groupadd user && useradd -m -g user user

# Pull in S6 Overlay & Tiger VNC
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/s6-overlay-amd64.tar.gz

# Setup VNC Server
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        python git \
        ca-certificates wget curl locales \
        sudo nginx \
        xorg openbox && \
    tar -xvf /tmp/s6-overlay-amd64.tar.gz && \
    # workaround for https://github.com/just-containers/s6-overlay/issues/158
    ln -s /init /init.entrypoint && \
    locale-gen en_US.UTF-8 && \
    # novnc
    mkdir -p /app/src && \
    git clone --depth=1 https://github.com/novnc/noVNC.git /app/src/novnc && \
    git clone --depth=1 https://github.com/novnc/websockify.git /app/src/websockify && \
    apt-get autoremove -y && \
    apt-get clean

# Install Viber DPKG Dependences
## We need several additional libraries for viber to work..
RUN apt-get install -y libpulse-dev libqt5gui5

# Repackage viber with libcurl4 support...
RUN curl -fL# http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb -o /usr/src/viber.deb && \
    cd /usr/src && dpkg-deb -x /usr/src/viber.deb viber && \
    dpkg-deb --control /usr/src/viber.deb viber/DEBIAN && \
    sed -i 's/libcurl3/libcurl4/g' viber/DEBIAN/control && \
    dpkg -b viber vibernew.deb

# Install Viber (new dpkg'd version)
RUN dpkg -i /usr/src/vibernew.deb > /dev/null 2>&1; if [ $? -gt 0 ]; then apt-get -f --force-yes --yes install>/dev/null 2>&1; fi && \
    dpkg -i /usr/src/vibernew.deb

RUN apt install -f && \
    dpkg -i /usr/src/vibernew.deb

# Auto-set timezone based on location...
RUN apt install -y python-pip && \
    pip install -U tzupdate

RUN apt-get install -y tigervnc-common tigervnc-standalone-server && \
    apt-get install -y xdg-utils wmctrl --fix-missing

# copy files
COPY ./docker-root /

EXPOSE 9000

ENTRYPOINT ["/init.entrypoint"]
CMD ["start"]
