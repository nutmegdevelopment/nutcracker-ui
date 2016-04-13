TARGET  ?= install

GO_VERSION ?= 1.6
DOCKER ?= docker
DOCKERTAG ?= latest
DOCKERREPO ?= localhost

install:
	$(DOCKER) run -v $(CURDIR):/go/bin -e CGO_ENABLED=0 --rm golang:$(GO_VERSION) go get -v github.com/nutmegdevelopment/nutcracker-ui
	$(DOCKER) build -t $(DOCKERREPO)/nutcracker-ui:$(DOCKERTAG) .
	rm -f nutcracker-ui

push:
	$(DOCKER) push $(DOCKERREPO)/nutcracker-ui:$(DOCKERTAG)

test:
	$(DOCKER) run -v $(CURDIR):/go/bin -e CGO_ENABLED=0 --rm golang:$(GO_VERSION) go get github.com/nutmegdevelopment/nutcracker-ui && go test github.com/nutmegdevelopment/nutcracker-ui

clean:
	rm -f nutcracker-ui
