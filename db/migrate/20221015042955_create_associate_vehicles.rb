class CreateAssociateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :associate_vehicles do |t|
      t.references :service_order, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
