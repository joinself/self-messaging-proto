# self-messaging-proto
Defines the protobuf files for messaging services and client

All changes to `.proto` files must be built before commiting.

#### Generating

To generate the go v1 proto bindings, run:
```$sh
$ make generate-v1
```

To generate the go v2 flatbuffer bindings, run:
```$sh
$ make generate-v2
```

## Protocol specifications

There are a number of different type of messages, these are distinguished by the specified type.

| Field | Type   | Required |
|-------|--------|----------|
| id    | string | yes      |
| type  | enum   | yes      |

Valid `type` enums are:
- MsgType_MSG  (0)
- MsgType_ACK  (1)
- MsgType_ERR  (2)
- MsgType_AUTH (3)
- MsgType_ACL  (4)

#### authentication

The first message that should be sent when connecting is an authentication message.

The JWT token provided must be signed by the identity denoted in the issuer `iss` field.

A device ID must also be provided to denote the id of the device that is connecting.

On a successful auth, the server will send back a `ACK` message. On a failure, an `ERR` message will be returned.

| Field   | Type   | Value           | Required |
|---------|--------|-----------------|----------|
| id      | string | UUID            | true     |
| type    | enum   | MsgType_AUTH    | true     |
| token   | string | valid jwt token | true     |
| device  | int32  | id of device    | true     |

#### message

Messages will be sent in real-time to the authenticated user.

On a successful message send, the server will reply with an `ACK`.

If there is an error sending the message, the server will respond with an `ERR` message.

| Field      | Type      | Value                | Required |
|------------|-----------|----------------------|----------|
| id         | string    | UUID                 | true     |
| type       | enum      | MsgType_MSG          | true     |
| sender     | string    | sender-id            | true     |
| recipient  | string    | recipient-id         | true     |
| ciphertext | bytes     | encrypted cyphertext | false    |
| timestamp  | timestamp | timestamp            | false    |


#### acl

Each identity has an access control list. This list determines what other identities are allowed to send messages to the server.

The ACL is a whitelist that requires a specific rule to a allow messages through. Rules can optionally specify an expiry time.

There are 3 acl commands, `LIST`, `PERMIT` and `REVOKE`.

| Field      | Type      | Value                                                   | Required |
|------------|-----------|---------------------------------------------------------|----------|
| id         | string    | UUID                                                    | true     |
| type       | enum      | MsgType_MSG                                             | true     |
| command    | enum      | ACLCommand_LIST, ACLCommand_PERMIT, ACLCommand_REVOKE   | true     |
| payload    | bytes     | JWS payload for permit, revoke. Array of rules for list | true     |


To list all active ACL rules, issue an ACL message with the `LIST` command.
The payload of the response will contain an array of rules.

```json
[
    {
        "acl_source": "self-id",
        "acl_exp": "RFC3339"
    }
]
```

To permit or revoke a sender, you must send an ACL message with the `PERMIT` or `REVOKE` command. The payload of the message will be a JWS payload signed by the identity. The payload of the JWS must contain the following fields:

```json
{
    "iss": "the issuing self ID",
    "acl_source": "id of the permitted|revoked self identity",
    "acl_exp": "RFC3339 time of rule expiry"
}
```

To allow messages from all identities, you can set the `acl_source` to `*`.

When the ACL has been updated, the server will respond with an `ACK` or `ERR message`.


#### acknowledgement

| Field      | Type      | Value         |
|------------|-----------|---------------|
| id         | string    | id of message |
| type       | enum      | MsgType_ACK   |

#### error

| Field      | Type      | Value                   |
|------------|-----------|-------------------------|
| id         | string    | UUID of related message |
| type       | enum      | MsgType_ERR             |
| error      | string    | error message           |
