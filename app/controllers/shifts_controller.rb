class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  # GET /shifts
  def index
    @shifts = Shift.all
  end

  # GET /shifts/:id
  def show
  end

  # GET /shifts/new
  def new
    @shift = Shift.new
  end

  # POST /shifts
  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      redirect_to @shift, notice: 'シフトが作成されました。'
    else
      render :new
    end
  end

  # GET /shifts/:id/edit
  def edit
  end

  # PATCH/PUT /shifts/:id
  def update
    if @shift.update(shift_params)
      redirect_to @shift, notice: 'シフトが更新されました。'
    else
      render :edit
    end
  end

  # DELETE /shifts/:id
  def destroy
    @shift.destroy
    redirect_to shifts_url, notice: 'シフトが削除されました。'
  end

  private

  # コールバックで共通のセットアップを共有
  def set_shift
    @shift = Shift.find(params[:id])
  end

  # 許可されたパラメータをリストに追加
  def shift_params
    params.require(:shift).permit(:name)
  end
end
