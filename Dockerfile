FROM alpine

LABEL maintainer="cicd_robot"

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL wunderman.commerce.vcs.ref=$VCS_REF \
      wunderman.commerce.vcs.url=$VCS_URL \
      wunderman.commerce.vcs.branch=$VCS_BRANCH \
      wunderman.commerce.build.date=$BUILD_DATE \
      wunderman.commerce.build.number=$BUILD_NUMBER \
      wunderman.commerce.maintainer="wunderman.commerce.com"

ENV KUBE_LATEST_VERSION="v1.13.2"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

WORKDIR /root
ENTRYPOINT ["kubectl"]
CMD ["help"]
