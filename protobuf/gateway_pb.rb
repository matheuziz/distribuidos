# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: protobuf/gateway.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("protobuf/gateway.proto", :syntax => :proto3) do
    add_message "TvUpdate" do
      optional :name, :string, 1
      optional :volume, :int32, 2
      optional :channel, :int32, 3
      optional :status, :bool, 4
    end
    add_message "AcUpdate" do
      optional :name, :string, 1
      optional :temperature, :int32, 2
      optional :mode, :enum, 3, "AcUpdate.Mode"
      optional :status, :bool, 4
    end
    add_enum "AcUpdate.Mode" do
      value :AUTO, 0
      value :COOL, 1
      value :DRY, 2
      value :FAN, 3
      value :HEAT, 4
    end
    add_message "LightUpdate" do
      optional :name, :string, 1
      optional :brightness, :int32, 2
      optional :color, :string, 3
    end
    add_message "Request" do
      oneof :update do
        optional :tv_update, :message, 1, "TvUpdate"
        optional :ac_update, :message, 2, "AcUpdate"
        optional :light_update, :message, 3, "LightUpdate"
      end
    end
  end
end

TvUpdate = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("TvUpdate").msgclass
AcUpdate = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("AcUpdate").msgclass
AcUpdate::Mode = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("AcUpdate.Mode").enummodule
LightUpdate = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("LightUpdate").msgclass
Request = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Request").msgclass
