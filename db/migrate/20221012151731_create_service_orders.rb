class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.string :source_address
      t.string :product_code
      t.integer :height
      t.integer :width
      t.integer :depth
      t.integer :weight
      t.string :destination_address
      t.string :recipient
      t.string :recipient_phone
      t.integer :total_distance
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
