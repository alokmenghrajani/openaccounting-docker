FROM golang:1.19-alpine as build

RUN apk add --no-cache --update gcc musl-dev libtool make git
RUN git clone https://github.com/openaccounting/oa-server.git
RUN cd oa-server && go build core/server.go

# Create a multi-stage build with the binary
FROM alpine

COPY --from=build go/oa-server/server /usr/bin/oa-server
COPY config.json .

ENTRYPOINT ["/usr/bin/oa-server"]

