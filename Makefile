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

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o ${APP} -ldflags "-X="github.com/MikityukVarvara/kbot/cmd.appVersion=${VERSION}

image: format get build
	docker build . -t ${REGISTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

push:
	docker push ${REGISTRY}${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

clean:
	docker rmi $(REGISTERY)/$(APP):$(VERSION)-$(TARGETARCH)
