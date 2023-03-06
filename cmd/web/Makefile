all: clean protoc webpack package-web compile test 

webpack:
	$(MAKE) -C webapp

package-web: webpack
	mkdir -p bin/web
	cp cmd/server/web/favicon.ico bin/web
	cp -a webapp/dist bin

clean:
	rm -rf gen
	rm -rf bin
	mkdir -p bin
	mkdir -p gen

PROTOC ?= protoc

protoc:
	$(PROTOC) -I ../.. ../../proto/*.proto --go_out=paths=source_relative:./gen --go-grpc_out=paths=source_relative:./gen

compile: clean protoc
	go build -v -o bin/vote-bot cmd/vote-bot/main.go
	go build -v -o bin/server cmd/server/main.go

test:
	go test ./...
