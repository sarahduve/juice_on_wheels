class Vehicle < ApplicationRecord
  has_many :vehicle_assignments
  has_many :battery_shifts, through: :vehicle_assignments

  reverse_geocoded_by :location_lat, :location_long, address: :last_parked_address
  after_validation :reverse_geocode, if: ->(obj){ !obj.in_use and obj.in_use_changed? }
end
