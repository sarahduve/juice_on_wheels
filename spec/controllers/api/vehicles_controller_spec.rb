require 'rails_helper'

module Api
  RSpec.describe VehiclesController, type: :controller do
    describe "#index" do
      let!(:battery_shift) { BatteryShift.create }
      let!(:vehicle) { Vehicle.create }
      let!(:assignment) { VehicleAssignment.create(battery_shift_id: battery_shift.id, vehicle_id: vehicle.id) }
      let(:params) { {battery_shift_id: battery_shift.id} }
      it " shows all vehicles in a shift" do
        get(:index, params: params)
        expect(response.status).to eq(200)
        body_hash = JSON.parse(response.body)
        expect(body_hash['data']['vehicles']).to eq([vehicle.as_json])
      end


    end

    describe "#show" do
      let!(:battery_shift) { BatteryShift.create }
      let!(:vehicle) { Vehicle.create }
      let!(:assignment) { VehicleAssignment.create(battery_shift_id: battery_shift.id, vehicle_id: vehicle.id, completed_at: Time.now) }
      let(:params) { {battery_shift_id: battery_shift.id, id: vehicle.id} }

      it "shows the status of a vehicle in a particular shift" do
        get(:show, params: params)
        expect(response.status).to eq(200)
        body_hash = JSON.parse(response.body)
        expect(body_hash['data']['complete']).to eq(true)
      end
    end
  end
end
