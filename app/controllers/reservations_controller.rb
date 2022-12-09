class ReservationsController < ApplicationController

  before_action :find_reservation, only: [:checkout]
  
  def checkout
    # render html: params
  end

  private

  def find_reservation
    @reservation = Reservation.find_by!(serial: params[:id])
  end

end