# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def random_coord (min, max)
  rand * (max-min) + min
end

100.times do
  Vehicle.create(location_lat: random_coord(40.615, 40.658), location_long: random_coord(-74, -73.9207), in_use: false)
end

# Vehicle.update(in_use: false)
