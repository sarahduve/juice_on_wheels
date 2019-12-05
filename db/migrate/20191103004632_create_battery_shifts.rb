class CreateBatteryShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :battery_shifts do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :complete, default: false
      t.references :employee, index: true, null: true, default: nil, foreign_key: true

      t.timestamps
    end
  end
end
