class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  # GET /registrations
  def index
    @registrations = Registration.all
  end

  # GET /registrations/1
  def show
  end

  # GET /registrations/new
  def new
    @registration = Registration.new
  end

  # GET /registrations/1/edit
  def edit
  end

  # POST /registrations
  def create
    @registration = Registration.new(registration_params)
    
    if @registration.save
      redirect_to @registration, notice: '登録が完了しました。'
    else
      render :new
    end
  end

  # PATCH/PUT /registrations/1
  def update
    if @registration.update(registration_params)
      redirect_to @registration, notice: '登録が更新されました。'
    else
      render :edit
    end
  end

  # DELETE /registrations/1
  def destroy
    @registration.destroy
    redirect_to registrations_url, notice: '登録が削除されました。'
  end

  private
    # コールバックで共通のセットアップを実行します。
    def set_registration
      @registration = Registration.find(params[:id])
    end

    # 信頼できるパラメータのみを許可します。
    def registration_params
      params.require(:registration).permit(:name, :ct, :yield)
    end
end
