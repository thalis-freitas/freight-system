class AddStatusToModeOfTransport < ActiveRecord::Migration[7.0]
  def change
    add_column :mode_of_transports, :status, :integer, default: 0
  end
end
