class ReservationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:information]
  before_action :find_reservation, only: [:checkout]
  
  def checkout
    @form_info = Newebpay::Mpg.new(@reservation).form_info

    @form_MerchantID = @form_info[:MerchantID]
    @form_TradeInfo = @form_info[:TradeInfo]
    @form_TradeSha = @form_info[:TradeSha]

  end

  def information
    response = Newebpay::MpgResponse.new(params[:TradeInfo])
    @MerchantID = response.result["MerchantID"] 
    @ItemDesc = response.result["ItemDesc"]
    @Amt = response.result["Amt"]
    @PayTime = response.result["PayTime"]
    @TradeNo = response.result["TradeNo"]
    @MerchantOrderNo = response.result["MerchantOrderNo"]
    

  end




  private

  def find_reservation
    @reservation = Reservation.find_by!(serial: params[:id])
  end

end