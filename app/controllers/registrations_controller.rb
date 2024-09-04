class RegistrationsController < ApplicationController
  def index
    @registrations = Registration.all.order(created_at: :desc)
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to registrations_path
    else
      render 'new'
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:name, :cycle_time, :output_rate)
  end
end
