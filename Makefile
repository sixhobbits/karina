
default: build
NAME:=platform-cli

VERSION:=v$(shell git tag --points-at HEAD ) $(shell date "+%Y-%m-%d %H:%M:%S")
.PHONY: setup
setup:
	which esc 2>&1 > /dev/null || go get -u github.com/mjibson/esc
	which github-release 2>&1 > /dev/null || go get github.com/aktau/github-release


.PHONY: build
build:
	go build -o ./.bin/$(NAME) -ldflags "-X \"main.version=$(VERSION)\""  main.go

.PHONY: pack
pack: setup
	esc --prefix "manifests/" --ignore "static.go" -o manifests/static.go --pkg manifests manifests

.PHONY: linux
linux:
	GOOS=linux go build -o ./.bin/$(NAME) -ldflags "-X \"main.version=$(VERSION)\""  main.go

.PHONY: darwin
darwin:
	GOOS=darwin go build -o ./.bin/$(NAME)_osx -ldflags "-X \"main.version=$(VERSION)\""  main.go

.PHONY: compress
compress:
	which upx 2>&1 >  /dev/null  || (sudo apt-get update && sudo apt-get install -y upx-ucl)
	upx ./.bin/$(NAME) ./.bin/$(NAME)_osx

.PHONY: install
install:
	cp ./.bin/$(NAME) /usr/local/bin/

.PHONY: docker
docker:
	docker build ./ -t $(NAME)

