class AddRegistrationIdToProductionPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :production_plans, :registration_id, :integer
  end
end
