#!/usr/bin/make -f

# COMMIT := $(shell git log -1 --format='%H')
NETWORK_TYPE := cia-v1

export GO111MODULE = on
export GOPROXY = https://goproxy.io
# windows, linux, darwin
export GOOS = linux
export GOARCH = amd64

# include ledger support
include Makefile.ledger

ldflags = -X 'ciablock.io/go-cia/version.NetworkType=$(NETWORK_TYPE)' \
          -X 'ciablock.io/go-cia/version.BuildTags=netgo'

BUILD_FLAGS := -tags "$(build_tags)" -ldflags "$(ldflags)"

all: build

build: go.sum
ifeq ($(OS),Windows_NT)
	go build -mod=readonly $(BUILD_FLAGS) -o build/windows/ciad.exe ./cmd/ciad
	go build -mod=readonly $(BUILD_FLAGS) -o build/windows/ciacli.exe ./cmd/ciacli
else
    UNAME_S := $(shell uname -s)
    goos_flag := linux
    ifeq ($(UNAME_S), Darwin)
        goos_flag = darwin
    endif
    ifeq ($(UNAME_S), OpenBSD)
        goos_flag = openbsd
    endif
    ifeq ($(UNAME_S), FreeBSD)
        goos_flag = freebsd
    endif
    ifeq ($(UNAME_S), NetBSD)
        goos_flag = netbsd
    endif
	GOOS=$(goos_flag) GOARCH=amd64 go build -mod=readonly $(BUILD_FLAGS) -o build/$(goos_flag)/ciad ./cmd/ciad
	GOOS=$(goos_flag) GOARCH=amd64 go build -mod=readonly $(BUILD_FLAGS) -o build/$(goos_flag)/ciacli ./cmd/ciacli
endif

build-windows: go.sum
	go build -mod=readonly $(BUILD_FLAGS) -o build/windows/ciad.exe ./cmd/ciad
	go build -mod=readonly $(BUILD_FLAGS) -o build/windows/ciacli.exe ./cmd/ciacli

build-linux: go.sum
# LEDGER_ENABLED=false GOOS=linux GOARCH=amd64 $(MAKE) build
	go build -mod=readonly -tags "netgo" -ldflags "$(ldflags)" -o build/linux/ciad ./cmd/ciad
	go build -mod=readonly -tags "netgo" -ldflags "$(ldflags)" -o build/linux/ciacli ./cmd/ciacli

build-mac: go.sum
# LEDGER_ENABLED=false GOOS=darwin GOARCH=amd64 $(MAKE) build
	go build -mod=readonly -tags "netgo" -ldflags "$(ldflags)" -o build/mac/ciad ./cmd/ciad
	go build -mod=readonly -tags "netgo" -ldflags "$(ldflags)" -o build/mac/ciacli ./cmd/ciacli

go-mod-cache: go.sum
	@echo "--> Download go modules to local cache"
	@go mod download

go.sum: go.mod
	@echo "--> Ensure dependecies have not been modified"
	@go mod verify
	@go mod tidy

clean:
	rm -rf build/

