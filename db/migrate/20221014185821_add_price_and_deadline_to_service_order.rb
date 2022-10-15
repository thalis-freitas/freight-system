class AddPriceAndDeadlineToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :price, :integer
    add_column :service_orders, :deadline, :integer
  end
end
