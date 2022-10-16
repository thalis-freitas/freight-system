class AddStartedInAndClosedInToServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :service_orders, :started_in, :datetime
    add_column :service_orders, :closed_in, :datetime
  end
end
