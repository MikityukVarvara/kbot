APP=$(shell basename $(shell git remote get-url origin))
REGISTERY=mikityuk
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETARCH=amd64


format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get 

build:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o kbot -ldflags "-X="github.com/MikityukVarvara/kbot/cmd.appVersion=v1.0.7

image:
	docker build . -t $(REGISTERY)/$(APP):$(VERSION)-$(TARGETARCH)

push:
	docker push $(REGISTERY)/$(APP):$(VERSION)-$(TARGETARCH)

clean:
	docker rmi $(REGISTERY)/$(APP):$(VERSION)-$(TARGETARCH)
