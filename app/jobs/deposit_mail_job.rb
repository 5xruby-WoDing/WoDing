class DepositMailJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    # Do something later
    SeatDepositMailer.deposit_notify(reservation).deliver
  end
end
