class ProductionPlan < ApplicationRecord
  before_save :calculate_operation_rate

  def calculate_operation_rate
    self.operation_rate = production_count.to_f / (cycle_time * operating_hours)
  end

  before_save :calculate_end_time

  def calculate_end_time
    self.end_time = start_time + (production_count.to_f / actual_count * 60).minutes
  end
end
