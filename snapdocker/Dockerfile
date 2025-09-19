ARG BASE=ubuntu-aayushi:v1


FROM ${BASE} AS tmp


COPY scripts/* /tmp/



RUN /tmp/install-requirements.sh
    
RUN /tmp/install-snap.sh

RUN /tmp/install-core20.sh && \
    /tmp/install-local-snaps.sh /tmp && \
    rm -rf /tmp/*

FROM ${BASE}
COPY --from=tmp / /


ENV PATH=/snap/bin:/snapcraft/current/usr/bin:$PATH
ENV SNAP=/snap/snapcraft/current
ENV SNAP_NAME=snapcraft
ENV SNAP_ARCH="arm64"