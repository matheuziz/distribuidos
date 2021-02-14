class Light < ApplicationRecord
  def self.from_protobuf(msg)
    new(
      name: msg.name,
      brightness: msg.brightness,
      status: msg.color
    )
  end

  def to_protobuf
    LightUpdate.new(
      name: self.name,
      brightness: self.brightness,
      color: self.color
    )
  end

  def serialize
    LightUpdate.encode(to_protobuf)
  end
end
