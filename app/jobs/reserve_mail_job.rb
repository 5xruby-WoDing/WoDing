class ReserveMailJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    
    ReserveMailer.reserve_notify(reservation).deliver
  end
end
