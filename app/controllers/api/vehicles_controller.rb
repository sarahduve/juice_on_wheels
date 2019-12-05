module Api
  class VehiclesController < ApplicationController
    # /api/battery_shifts/:battery_shift_id/vehicles(.:format)
    # show all vehicles in a shift
    def index
      battery_shift = BatteryShift.find(params[:battery_shift_id])
      vehicles = battery_shift.vehicles
      render json: { data: {vehicles: vehicles} }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: [detail: "#{e.message}"]}, status: :not_found
    end

    # /api/battery_shifts/:battery_shift_id/vehicles/:id(.:format)
    # show details for a vehicle in the context of a shift
    def show
      vehicle_status = VehicleAssignment.where(vehicle_id: params[:id], battery_shift_id: params[:battery_shift_id]).first
      render json: { data: {complete: !vehicle_status.completed_at.nil?} }, status: :ok
    end
  end
end
