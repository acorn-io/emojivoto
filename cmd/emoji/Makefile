all: clean compile test

clean:
	rm -rf gen
	rm -rf bin
	mkdir -p bin
	mkdir -p gen

PROTOC ?= protoc

protoc:
	$(PROTOC) -I ../.. ../../proto/*.proto --go_out=paths=source_relative:./gen --go-grpc_out=paths=source_relative:./gen

compile: protoc
	go build -v -o bin/emoji main.go

test:
	go test ./...

