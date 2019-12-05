module Api
  class BatteryShiftsController < ApplicationController
    # create a shift
    # /api/battery_shifts(.:format)
    def create
      battery_shift = BatteryShift.create!(battery_shift_params)
      if params.has_key?(:location_lat) && params.has_key?(:location_long)
        battery_shift.auto_assign_vehicles(params[:location_lat], params[:location_long])
      end
      render json: { data: battery_shift }, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: {error: "#{e.message}"}, status: :unprocessable_entity
    end

    # show a shift's status
    # /api/battery_shifts/:id(.:format)
    def show
      battery_shift = BatteryShift.find(params[:id])
      # NB: this will return true if no vehicles have been assigned yet
      shift_status = battery_shift.vehicle_assignments.map(&:completed_at).all?
      render json: { data: {complete: shift_status}}, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: "#{e.message}"}, status: :not_found
    end

    private

    def battery_shift_params
      params.permit(:start_time, :end_time, :employee_id)
    end
  end
end
