# frozen_string_literal: true

class DepositMailJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    SeatDepositMailer.deposit_notify(reservation).deliver
  end
end
