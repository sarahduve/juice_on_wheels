module Api
  class VehicleAssignmentsController < ApplicationController
    # assign a vehicle to a shift
    def create
      vehicle_assignment = VehicleAssignment.create!(vehicle_assignment_params)
      render json: { data: [vehicle_assignment] }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: [ detail: "#{e.message}" ]}, status: :unprocessable_entity
    end

    private

    def vehicle_assignment_params
      params.permit(:vehicle_id, :battery_shift_id)
    end
  end
end
