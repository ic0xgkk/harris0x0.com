FROM node:23-bookworm AS builder

RUN apt update && \
    apt install -y \
        ca-certificates \
        wget && \
    update-ca-certificates

ARG HUGO_VERSION="0.143.1"
RUN wget --quiet "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz" && \
    tar xzf hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    rm -r hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    mv hugo /usr/bin && \
    chmod 755 /usr/bin/hugo

COPY ./ /work
WORKDIR /work

RUN npm install && \
    npm run build

FROM scratch AS exporter
COPY --from=builder /work/public/ .
