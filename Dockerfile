FROM --platform=$BUILDPLATFORM golang:1.21.6-alpine3.18 AS builder

RUN apk add --update --no-cache ca-certificates make git curl

ARG TARGETOS
ARG TARGETARCH
ARG TARGETPLATFORM

WORKDIR /usr/local/src/logging-operator

ARG GOPROXY

# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum
COPY pkg/sdk/go.mod pkg/sdk/go.mod
COPY pkg/sdk/go.sum pkg/sdk/go.sum
COPY pkg/sdk/logging/model/syslogng/config/go.mod pkg/sdk/logging/model/syslogng/config/go.mod
COPY pkg/sdk/logging/model/syslogng/config/go.sum pkg/sdk/logging/model/syslogng/config/go.sum

# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
RUN go mod download

# Copy the go source
COPY main.go main.go
COPY controllers/ controllers/
COPY pkg/ pkg/

# Build
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /usr/local/bin/manager

FROM builder as debug

RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go install github.com/go-delve/delve/cmd/dlv@latest

CMD ["/go/bin/dlv", "--listen=:40000", "--headless=true", "--api-version=2", "--accept-multiclient", "exec", "/usr/local/bin/manager"]

FROM gcr.io/distroless/static:latest@sha256:9be3fcc6abeaf985b5ecce59451acbcbb15e7be39472320c538d0d55a0834edc

COPY --from=builder /usr/local/bin/manager /manager

ENTRYPOINT ["/manager"]
