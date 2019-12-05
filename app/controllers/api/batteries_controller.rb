module Api
  class BatteriesController < ApplicationController
    # /api/vehicles/:vehicle_id/battery(.:format)
    # update the battery for a vehicle
    def update
      vehicle = Vehicle.find(params[:vehicle_id])
      vehicle.update_attributes(battery_level: 1)
      assignment = VehicleAssignment.where(vehicle_id: vehicle.id, battery_shift_id: params[:battery_shift_id]).first
      assignment.update_attributes(completed_at: Time.now)
      render json: { data: [vehicle] }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: [ detail: "#{e.message}"]}, status: :not_found
    end
  end
end
