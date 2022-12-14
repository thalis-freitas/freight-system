class AddIndexToNameplate < ActiveRecord::Migration[7.0]
  def change
    add_index :vehicles, :nameplate, unique: true
  end
end
