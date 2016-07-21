FROM jenkins:2.7.1
MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

# Reset user to root.
USER root

# The gosu version.
ENV GOSU_VERSION 1.9

# Install gosu
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true
    # Nothing to remove
    # && apt-get purge -y wget

# add entrypoint script
COPY docker-entrypoint.sh /
RUN set -x \
    && chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# Run Jenkins as jenkins user.
CMD ["gosu", "jenkins", "/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
