# frozen_string_literal: true

class SeatDepositMailer < ApplicationMailer
  def deposit_notify(reservation)
    @reservation = reservation
    @deposit = reservation.seat.deposit
    @deposit_url = "#{ENV['WEB_DOMAIN']}/reservations/#{reservation.serial}/checkout"
    # @deposit_url = "http://localhost:3000/reservations/#{reservation.serial}/checkout"
    
 
    mail to: reservation.email, subject: '訂位付款連結，付完款後才會完成訂位'
  end
end
