class Tv < ApplicationRecord
  def self.from_protobuf(msg)
    new(
      name: msg.name,
      channel: msg.channel,
      volume: msg.volume,
      status: msg.status
    )
  end

  def to_protobuf
    TvUpdate.new(
      name: self.name,
      channel: self.channel,
      volume: self.volume,
      status: self.status
    )
  end

  def serialize
    TvUpdate.encode(to_protobuf)
  end
end
