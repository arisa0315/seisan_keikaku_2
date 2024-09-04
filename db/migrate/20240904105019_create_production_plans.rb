class CreateProductionPlans < ActiveRecord::Migration[7.2]
  def change
    create_table :production_plans do |t|
      t.integer :production_count
      t.integer :actual_count
      t.decimal :operation_rate
      t.datetime :start_time
      t.datetime :end_time
      t.string :shift_start
      t.string :shift_change

      t.timestamps
    end
  end
end
