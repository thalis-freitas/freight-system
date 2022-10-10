class CreatePriceByWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :price_by_weights do |t|
      t.integer :minimum_weight
      t.integer :maximum_weight
      t.integer :value
      t.references :mode_of_transport, null: false, foreign_key: true

      t.timestamps
    end
  end
end
