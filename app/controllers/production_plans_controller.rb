class ProductionPlansController < ApplicationController
  before_action :set_production_plan, only: [:show, :edit, :update, :destroy]

  # GET /production_plans
  def index
    @production_plans = ProductionPlan.all
    @shifts = Shift.all
  end

  # GET /production_plans/:id
  def show
  end

  # GET /production_plans/new
  def new
    @production_plan = ProductionPlan.new
    @shifts = Shift.all
  end

  # POST /production_plans
  def create
    @production_plan = ProductionPlan.new(production_plan_params)
    @shifts = Shift.all

    # 時間の処理
    if params[:production_plan][:start_hour].present? && params[:production_plan][:start_minute].present?
      start_time = Time.zone.parse("#{params[:production_plan][:start_hour]}:#{params[:production_plan][:start_minute]}")
      @production_plan.start_time = start_time
    end

    # C.Tと出来高の計算を行う（仮にRegistrationから取得するものとする）
    registration = Registration.find(params[:production_plan][:registration_id])
    ct = registration.ct
    yield_percentage = registration.yield

    # 可動率を計算
    if @production_plan.actual.present? && ct.present?
      production_time = (Time.now - @production_plan.start_time) / 3600 # 時間に変換
      @production_plan.operation_rate = (@production_plan.actual * ct) / production_time
    end

    # 終了予定時刻の計算
    if @production_plan.production_count.present? && ct.present? && yield_percentage.present?
      break_time = 1.hour # 休憩時間を仮に1時間と設定
      end_time = @production_plan.start_time + (@production_plan.production_count / (ct / yield_percentage)) + break_time
      @production_plan.end_time = end_time
    end

    if @production_plan.save
      redirect_to @production_plan, notice: '生産計画が作成されました。'
    else
      render :new
    end
  end

  # GET /production_plans/:id/edit
  def edit
    @shifts = Shift.all
  end

  # PATCH/PUT /production_plans/:id
  def update
    # 時間の処理
    if params[:production_plan][:start_hour].present? && params[:production_plan][:start_minute].present?
      start_time = Time.zone.parse("#{params[:production_plan][:start_hour]}:#{params[:production_plan][:start_minute]}")
      @production_plan.start_time = start_time
    end

    # C.Tと出来高の計算（新規作成と同様）
    registration = Registration.find(params[:production_plan][:registration_id])
    ct = registration.ct
    yield_percentage = registration.yield

    # 可動率を再計算
    if @production_plan.actual.present? && ct.present?
      production_time = (Time.now - @production_plan.start_time) / 3600 # 時間に変換
      @production_plan.operation_rate = (@production_plan.actual * ct) / production_time
    end

    # 終了予定時刻の再計算
    if @production_plan.production_count.present? && ct.present? && yield_percentage.present?
      break_time = 1.hour # 休憩時間
      end_time = @production_plan.start_time + (@production_plan.production_count / (ct / yield_percentage)) + break_time
      @production_plan.end_time = end_time
    end

    if @production_plan.update(production_plan_params)
      redirect_to @production_plan, notice: '生産計画が更新されました。'
    else
      render :edit
    end
  end

  # DELETE /production_plans/:id
  def destroy
    @production_plan.destroy
    redirect_to production_plans_url, notice: '生産計画が削除されました。'
  end

  private

  # 共通メソッド: 生産計画のセット
  def set_production_plan
    @production_plan = ProductionPlan.find(params[:id])
  end

  # ストロングパラメーター
  def production_plan_params
    params.require(:production_plan).permit(:production_count, :actual, :start_time, :shift_id, :change_shift_id, :registration_id)
  end
end
