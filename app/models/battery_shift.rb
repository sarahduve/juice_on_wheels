class BatteryShift < ApplicationRecord
  has_many :vehicle_assignments
  has_many :vehicles, through: :vehicle_assignments
  belongs_to :employee, optional: true

  def auto_assign_vehicles(lat, long)
    vehicles = Vehicle.near([lat, long], 5).limit(20)
    ordered_vehicles = [vehicles.shift]
    while !vehicles.empty?
      distances = vehicles.map do |v|
        v.distance_to(ordered_vehicles.last)
      end
      ordered_vehicles << vehicles.slice!(distances.index(distances.min))
    end
    vehicles = ordered_vehicles
  end
end
