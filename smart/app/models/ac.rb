class Ac < ApplicationRecord

  def self.from_protobuf(msg)
    new(
      name: msg.name,
      mode: msg.mode,
      status: msg.status
    )
  end

  def to_protobuf
    AcUpdate.new(
      name: self.name,
      mode: self.mode.upcase.to_sym,
      temperature: self.temperature,
      status: self.status
    )
  end

  def serialize
    AcUpdate.encode(to_protobuf)
  end
end
