class Backstage::ReservationsController < ApplicationController
  before_action :find_reservation_id, only: [:finish]


  def finish
    
    @reservation = Reservation.find_by!(id: params[:id])
    if @reservation.may_cancel?
      @reservation.cancel!
    end

    redirect_to backstage_restaurant_path(@reservation.restaurant), notice: "成功結束訂單"
  end
  

    

  private
  def find_reservation_id
    @reservation = Reservation.find_by!(id: params[:id])
  end
end