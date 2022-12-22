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

    @merchant_id = response.result["MerchantID"] 
    @item_desc = response.result["ItemDesc"]
    @amt = response.result["Amt"]
    @pay_time = response.result["PayTime"]
    @trade_no = response.result["TradeNo"]
    @merchant_order_no = response.result["MerchantOrderNo"]
    @card6_no = response.result["Card6No"]
    @card4_no = response.result["Card4No"]
    @trade_no = response.result["TradeNo"]
    @payment_type = response.result["PaymentType"]
    @trans_no = response.trans_no


  end

  private

  def find_reservation
    @reservation = Reservation.find_by!(serial: params[:id])
  end
end
