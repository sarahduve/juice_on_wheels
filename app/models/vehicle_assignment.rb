class VehicleAssignment < ApplicationRecord
  belongs_to :vehicle
  belongs_to :battery_shift

  validates_presence_of :vehicle, :battery_shift
end
