# -------- builder stage -------- #
FROM golang:alpine AS builder

ARG GOOS_VAL=linux
ARG GOARCH=amd64

WORKDIR $GOPATH/src/terrascan

# download go dependencies
COPY go.mod go.sum ./
RUN go mod download

# copy terrascan source
COPY . .

# build binary
RUN GOOS=${GOOS_VAL} GOARCH=${GOARCH_VAL} go build -v -ldflags "-w -s" -o /go/bin/terrascan ./cmd/terrascan


# -------- prod stage -------- #
FROM alpine:3.12.0

# create non root user
RUN addgroup --gid 101 terrascan && \
    adduser -S --uid 101 --ingroup terrascan terrascan

# run as non root user
USER terrascan

# copy terrascan binary from build
COPY --from=builder /go/bin/terrascan /go/bin/terrascan 

EXPOSE 9010

ENTRYPOINT ["/go/bin/terrascan", "--server"]
CMD ["--log-type", "json"]
