# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: errtype.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("errtype.proto", :syntax => :proto3) do
    add_enum "msgproto.ErrType" do
      value :ErrConnection, 0
      value :ErrBadRequest, 1
      value :ErrInternal, 2
      value :ErrMessage, 3
      value :ErrAuth, 4
      value :ErrACL, 5
    end
  end
end

module Msgproto
  ErrType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("msgproto.ErrType").enummodule
end