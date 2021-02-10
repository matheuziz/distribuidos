# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tv.create(
  [{name: 'LGTV 777 Matue', channel: 23, volume: 69}]
)

Ac.create(
  [{name: 'Consul', temperature: 23, mode: 'Cool'}]
)

Light.create(
  [{name: 'LEDStrip HXY2134', color: 'red', brightness: 100}]
)
