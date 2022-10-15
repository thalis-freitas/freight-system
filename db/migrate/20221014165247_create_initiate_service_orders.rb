class CreateInitiateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :initiate_service_orders do |t|
      t.references :service_order, null: false, foreign_key: true
      t.references :mode_of_transport, null: false, foreign_key: true

      t.timestamps
    end
  end
end
