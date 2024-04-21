APP=$(shell basename $(shell git remote get-url origin))
REGISTERY=mikityuk

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

image: 
	docker build . -t ${REGISTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

push:
	docker push ${REGISTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
	
clean: 
	docker rmi ${REGISTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

