# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: auth.proto

require 'google/protobuf'

require 'msgtype_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("auth.proto", :syntax => :proto3) do
    add_message "msgproto.Auth" do
      optional :type, :enum, 1, "msgproto.MsgType"
      optional :id, :string, 2
      optional :token, :string, 3
      optional :device, :string, 4
      optional :offset, :uint64, 5
    end
  end
end

module Msgproto
  Auth = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("msgproto.Auth").msgclass
end
