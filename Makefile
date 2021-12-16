GOCMD=go
GOTEST=$(GOCMD) test -v
GOBUILD=$(GOCMD) build
BINARY_NAME=medit

all: build deploy

test:
	$(GOTEST) ./pkg/*

build:
	GOOS=linux GOARCH=arm64 GOARM=7 $(GOBUILD) -o $(BINARY_NAME)

build-linux:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_NAME)

clean:
	rm $(BINARY_NAME)

deploy:
ifeq ($(shell adb devices | grep -c 'device$$'), 1)
	$(SHELL) -c "adb push $(BINARY_NAME) /data/local/tmp/$(BINARY_NAME)"
else
	@echo 'Android device is not connected....'
endif
