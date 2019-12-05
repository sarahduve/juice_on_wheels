class AddLastParkedAddressToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :last_parked_address, :string
  end
end
