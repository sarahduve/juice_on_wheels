require 'rails_helper'

module Api
  RSpec.describe BatteryShiftsController, type: :controller do
    describe "#create" do
      # before(:all) do
        # 20.times do
          # Vehicle.create(location_lat: random_coord(40.615, 40.658), location_long: random_coord(-74, -73.9207), in_use: false)
        # end
      # end

      let(:params) {
        { start_time: "2019-11-05 20:00:00",
          end_time: "2019-11-05 22:00:0"}
      }

      let(:lat_long) {
        { location_lat: 40.64181327532475,
          location_long: -73.98185534280718 }
      }

      it "creates a new battery shift and returns the object" do
        post(:create, params: params)
        expect(response.status).to eq(201)
        body_hash = JSON.parse(response.body)
        battery_shift = BatteryShift.last
        expect(body_hash['data']['id']).to eq(battery_shift.id)
      end

      # need to create 20 Vehicles to test auto assignment, see before block
      # above, but because it's calling an external API 20 times, it makes this
      # test very slow
      it "when given a lat long, it automatically adds vehicles to shift" do
        post(:create, params: params.merge(lat_long))
        expect(response.status).to eq(201)
        body_hash = JSON.parse(response.body)
        battery_shift = BatteryShift.last
        expect(body_hash['data']['id']).to eq(battery_shift.id)
        # expect(battery_shift.vehicles.count).to eq(20)
      end

      def random_coord (min, max)
        rand * (max-min) + min
      end

    end

    describe "#show" do
      let(:battery_shift) { BatteryShift.create }
      let(:vehicle) { Vehicle.create }
      let(:assignment) { VehicleAssignment.create(battery_shift_id: battery_shift.id, vehicle_id: vehicle.id, completed_at: Time.now)}
      let(:params) { {id: battery_shift.id} }

      it "returns whether or not battery shift is complete" do
        get(:show, params: params)
        expect(response.status).to eq(200)
        body_hash = JSON.parse(response.body)
        expect(body_hash['data']['complete']).to eq(true)
      end
    end
  end
end
