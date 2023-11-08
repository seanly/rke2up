FROM rockylinux:8 as download

ARG RKE2_VERSION=v1.26.10+rke2r1

COPY ./scripts/download.sh /
RUN mkdir -p /rke2/; cd /rke2; bash /download.sh ${RKE2_VERSION}

FROM seanly/scratch
ARG RKE2_VERSION=v1.26.10+rke2r1

COPY ./ /rke2
COPY --from=download /rke2/ /rke2/
