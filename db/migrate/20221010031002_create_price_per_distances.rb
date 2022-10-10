class CreatePricePerDistances < ActiveRecord::Migration[7.0]
  def change
    create_table :price_per_distances do |t|
      t.integer :minimum_distance
      t.integer :maximum_distance
      t.integer :rate
      t.references :mode_of_transport, null: false, foreign_key: true

      t.timestamps
    end
  end
end
