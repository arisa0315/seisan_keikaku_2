class Shift < ApplicationRecord
   has_many :production_plans
  has_many :change_production_plans, class_name: 'ProductionPlan', foreign_key: 'change_shift_id'
end
