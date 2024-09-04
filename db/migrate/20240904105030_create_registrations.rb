class CreateRegistrations < ActiveRecord::Migration[7.2]
  def change
    create_table :registrations do |t|
      t.string :name
      t.integer :cycle_time
      t.decimal :output_rate

      t.timestamps
    end
  end
end
