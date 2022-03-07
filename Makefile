generate:
#	go get -u github.com/golang/protobuf/protoc-gen-go
	protoc --go_out=out msgtype.proto errtype.proto message.proto acl.proto aclcommand.proto notification.proto header.proto auth.proto