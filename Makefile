APP=$(shell basename $(shell git remote get-url origin))
REGISTERY=mikityuk
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)


format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get 

build:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o kbot -ldflags "-X="github.com/MikityukVarvara/kbot-main/cmd.appVersion=${VERSION}

image:
	docker build . -t $(REGISTERY)/$(APP):$(VERSION)-$(TARGETARCH)

push:
	docker push $(REGISTERY)/$(APP):$(VERSION)-$(TARGETARCH)

clean:
	docker rmi 0f59544e99fe