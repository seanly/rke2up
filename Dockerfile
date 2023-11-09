FROM rockylinux:8 as download

ARG RKE2_VERSION=v1.26.10+rke2r1

COPY ./lib/download.sh /
RUN mkdir -p /rke2up/; cd /rke2up; bash /download.sh ${RKE2_VERSION}

FROM seanly/scratch as latest
ARG RKE2_VERSION=v1.26.10+rke2r1

COPY ./ /rke2up

FROM seanly/scratch
ARG RKE2_VERSION=v1.26.10+rke2r1

COPY ./ /rke2up
COPY --from=download /rke2up/ /rke2up/
