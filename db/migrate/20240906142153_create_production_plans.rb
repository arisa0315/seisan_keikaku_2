class CreateProductionPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :production_plans do |t|
      t.integer :production_count, null: false
      t.integer :actual, null: false
      t.float :operation_rate, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.references :shift, foreign_key: { to_table: :shifts }, null: false
      t.references :change_shift, foreign_key: { to_table: :shifts }

      t.timestamps
    end
  end
end
