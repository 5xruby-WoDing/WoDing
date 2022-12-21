# frozen_string_literal: true

class ReservationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:information]
  before_action :find_reservation, only: [:checkout]

  def checkout
    @form_info = Newebpay::Mpg.new(@reservation).form_info

    @form_merchant_id = @form_info[:MerchantID]
    @form_trade_info = @form_info[:TradeInfo]
    @form_trade_sha = @form_info[:TradeSha]
  end

  def information
    response = Newebpay::MpgResponse.new(params[:TradeInfo])
    @merchant_id = response.result['MerchantID']
    @item_desc = response.result['ItemDesc']
    @amt = response.result['Amt']
    @pay_time = response.result['PayTime']
    @trade_no = response.result['TradeNo']
    @merchant_order_no = response.result['MerchantOrderNo']
  end

  private

  def find_reservation
    @reservation = Reservation.find_by!(serial: params[:id])
  end
end
