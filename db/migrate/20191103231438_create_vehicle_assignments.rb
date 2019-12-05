class CreateVehicleAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicle_assignments do |t|
      t.references :battery_shift, index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
