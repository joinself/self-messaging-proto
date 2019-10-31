generate:
	go get -u github.com/golang/protobuf/protoc-gen-go
	protoc --go_out=. msgtype.proto
	protoc --go_out=. message.proto
	protoc --go_out=. acl.proto
	protoc --go_out=. aclcommand.proto
	protoc --go_out=. notification.proto
	protoc --go_out=. header.proto
	protoc --go_out=. auth.proto
