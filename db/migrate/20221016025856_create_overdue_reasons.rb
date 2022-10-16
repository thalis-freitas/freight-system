class CreateOverdueReasons < ActiveRecord::Migration[7.0]
  def change
    create_table :overdue_reasons do |t|
      t.references :service_order, null: false, foreign_key: true
      t.string :overdue_reason

      t.timestamps
    end
  end
end
