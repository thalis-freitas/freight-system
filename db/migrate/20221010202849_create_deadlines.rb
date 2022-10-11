class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.integer :minimum_distance
      t.integer :maximum_distance
      t.integer :estimated_time
      t.references :mode_of_transport, null: false, foreign_key: true

      t.timestamps
    end
  end
end
