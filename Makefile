generate-v1:
	cd v1
	protoc --go_out=. msgtype.proto
	protoc --go_out=. errtype.proto
	protoc --go_out=. message.proto
	protoc --go_out=. notification.proto
	protoc --go_out=. header.proto
	protoc --go_out=. auth.proto
	protoc --go_out=. status.proto
	protoc --go_out=. watch.proto

generate-v2:
	cd v2
	flatc --go *.fbs
	flatc --cpp *.fbs
	flatc --ts *.fbs
