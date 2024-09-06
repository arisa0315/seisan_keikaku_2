class CreateRegistrations < ActiveRecord::Migration[7.2]
  def change
    create_table :registrations do |t|
      t.string :name
      t.integer :ct
      t.float :yield

      t.timestamps
    end
  end
end
