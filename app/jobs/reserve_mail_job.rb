class ReserveMailJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    # Do something later
    ReserveMailer.reserve_notify(reservation).deliver
  end
end
