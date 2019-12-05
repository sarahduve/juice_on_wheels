require 'rails_helper'

module Api
  RSpec.describe BatteriesController, type: :controller do
    describe "#update" do
      let!(:battery_shift) { BatteryShift.create }
      let!(:vehicle) { Vehicle.create }
      let!(:assignment) { VehicleAssignment.create(battery_shift_id: battery_shift.id, vehicle_id: vehicle.id) }
      let(:params) { {battery_shift_id: battery_shift.id, vehicle_id: vehicle.id} }

      it "sets the battery level to 1.00 and completes vehicle assignment" do
        patch(:update, params: params)
        expect(response.status).to eq(200)
        expect(vehicle.reload.battery_level).to eq(1)
        expect(assignment.reload.completed_at).not_to eq(nil)
      end
    end
  end
end
