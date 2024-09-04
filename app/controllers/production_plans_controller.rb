class ProductionPlansController < ApplicationController
  def index
    @production_plans = ProductionPlan.all
  end

  def new
    @production_plan = ProductionPlan.new
  end

  def create
    @production_plan = ProductionPlan.new(production_plan_params)
    if @production_plan.save
      redirect_to production_plans_path, notice: '生産計画が登録されました。'
    else
      render :new
    end
  end

  private

  def production_plan_params
    params.require(:production_plan).permit(:production_count, :actual_count, :start_time, :shift_start, :shift_change)
  end
end
