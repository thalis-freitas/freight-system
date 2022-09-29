class CreateModeOfTransports < ActiveRecord::Migration[7.0]
  def change
    create_table :mode_of_transports do |t|
      t.string :name
      t.integer :minimum_distance
      t.integer :maximum_distance
      t.integer :minimum_weight
      t.integer :maximum_weight
      t.integer :flat_rate

      t.timestamps
    end
  end
end
