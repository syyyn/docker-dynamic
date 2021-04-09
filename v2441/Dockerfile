FROM debian

RUN useradd -r dynamic \
  && apt-get update -y \
  && apt-get install -y curl gnupg gosu \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG TARGETPLATFORM
ENV TARGETPLATFORM=linux/amd64
ENV DYNAMIC_VERSION=2.4.4.1
ENV DYNAMIC_DATA=/home/dynamic/.dynamic
ENV PATH=/opt/dynamic-2.4.4/bin:$PATH
RUN set -ex \
  && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGETPLATFORM=Linux-x64; fi \
  && for key in \
    01EA5486DE18A882D4C2684590C8019E36C2E964 \
  ; do \
      gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key" || \
      gpg --batch --keyserver pgp.mit.edu --recv-keys "$key" || \
      gpg --batch --keyserver keyserver.pgp.com --recv-keys "$key" || \
      gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
      gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
    done \
  && curl -SLO https://github.com/duality-solutions/Dynamic/releases/download/v${DYNAMIC_VERSION}/Dynamic-${DYNAMIC_VERSION}-${TARGETPLATFORM}.tar.gz \
  && tar -xzvf *.tar.gz -C /opt \
  && rm *.tar.gz \
  && rm -rf /opt/dynamic-2.4.4/bin/dynamic-qt

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/dynamic/.dynamic"]

EXPOSE 33300 33350

ENTRYPOINT ["/entrypoint.sh"]

CMD ["dynamicd"]