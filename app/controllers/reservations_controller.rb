class ReservationsController < ApplicationController

  before_action :find_reservation, only: [:checkout]
  
  def checkout
    @form_info = Newebpay::Mpg.new(@reservation).form_info

    @form_MerchantID = @form_info[:MerchantID]
    @form_TradeInfo = @form_info[:TradeInfo]
    @form_TradeSha = @form_info[:TradeSha]

  end




  private

  def find_reservation
    @reservation = Reservation.find_by!(serial: params[:id])
  end

end