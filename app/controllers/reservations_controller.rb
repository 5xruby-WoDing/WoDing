class ReservationsController < ApplicationController

  before_action :find_reservation, only: [:checkout]
  
  def checkout
    
  end

  private

  def find_reservation
    @reservation = Reservation.find_by!(id: params[:id])
  end

end