require 'rails_helper'

module Api
  RSpec.describe VehicleAssignmentsController, type: :controller do
    describe "#create" do
      let(:battery_shift) { BatteryShift.create }
      let(:vehicle) { Vehicle.create }
      let(:params) { {battery_shift_id: battery_shift.id, vehicle_id: vehicle.id} }

      it "Assigns a vehicle to a battery shift" do
        post(:create, params: params)
        expect(response.status).to eq(201)
        expect(battery_shift.vehicles).to eq([vehicle])
      end
    end
  end
end
