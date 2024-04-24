APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=mikityuk

VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETARCH=amd64
TARGETOS=linux


format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get 

build:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o kbot -ldflags "-X="github.com/MikityukVarvara/kbot/cmd.appVersion=${VERSION}

image: 
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
	
clean: 
	docker rmi ${REGISTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
