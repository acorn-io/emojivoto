FROM node:18 as webpack

WORKDIR /build

COPY emojivoto-web .

RUN make package-web

FROM golang:1.19 as bins

WORKDIR /build

RUN apt update && \
    apt install -y protobuf-compiler && \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.27.1 && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1.0

COPY emojivoto-web emojivoto-web
COPY go.mod .
COPY go.sum .
COPY Makefile .
ADD proto proto
RUN make compile-web

FROM golang:1.19 as runner

WORKDIR /app

COPY --from=webpack /build/bin/dist ./dist
ENV INDEX_BUNDLE "dist/index_bundle.js"

COPY --from=bins /build/emojivoto-web/bin/emojivoto-vote-bot /usr/local/bin/emojivoto-vote-bot
COPY --from=bins /build/emojivoto-web/bin/emojivoto-web /usr/local/bin/emojivoto-web
