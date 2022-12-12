class ReservationsController < ApplicationController

  before_action :find_reservation, only: [:checkout]
  
  def checkout
    # render html: params
    if @reservation.may_reserve?
      @reservation.reserve!
    end
  end

  def finish

    @reservation = Reservation.find_by!(id: params[:id])
    if @reservation.may_cancel?
      @reservation.cancel!
    end

    redirect_to backstage_restaurant_path(@reservation.restaurant), notice: "成功結束訂單"
  end

  private

  def find_reservation
    @reservation = Reservation.find_by!(serial: params[:id])
  end

end