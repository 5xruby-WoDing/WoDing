class Backstage::ReservationsController < ApplicationController

    before_action :find_reservation_id, only: [:destroy]
  
    def destroy
      @reservation.destroy
  
      redirect_to backstage_restaurant_path(@reservation.restaurant)
    end
  
    private
    def find_reservation_id
      @reservation = Reservation.find_by!(id: params[:id])
    end
    
  end