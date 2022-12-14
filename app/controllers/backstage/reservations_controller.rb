class Backstage::ReservationsController < ApplicationController
  before_action :authenticate_manager!
  before_action :find_reservation_id, only: [:destroy, :mark]
  
  def destroy
    @reservation.destroy
  
    redirect_to backstage_restaurant_path(@reservation.restaurant)
  end

  def mark
    
    if current_manager.marked_reservations.include?(@reservation)
      current_manager.marked_reservations.delete(@reservation)
      render json: {status: "not mark", manager: current_manager.id, reservation: @reservation.id}
    else
      current_manager.marked_reservations << @reservation
      render json: {status: "mark", manager: current_manager.id, reservation: @reservation.id}
    end    
    
  end
  
  private
  def find_reservation_id
    @reservation = Reservation.find_by!(id: params[:id])
  end
end