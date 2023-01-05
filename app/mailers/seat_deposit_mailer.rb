# frozen_string_literal: true

class SeatDepositMailer < ApplicationMailer
  def deposit_notify(reservation)
    @reservation = reservation
    @deposit = reservation.seat.deposit

    mail to: reservation.email, subject: '訂位付款連結，付完款後才會完成訂位'
  end
end
