class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.all
  end

  def new
    @registration = Registration.new
    @registrations = Registration.all # ここで全ての登録を取得します
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to new_registration_path, notice: '登録が完了しました。'
    else
      @registrations = Registration.all # エラー時も一覧を再度表示するため
      render :new
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:name, :cycle_time, :output_rate)
  end
end
