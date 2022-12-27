# frozen_string_literal: true

class ReserveMailJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    ReserveMailer.reserve_notify(reservation).deliver

    sms_client = Twsms2::Client.new(username: ENV['TWSMS_ACCOUNT'], password: ENV['TWSMS_PASSWORD'])
    sms_client.send_message to: "#{reservation.phone}", content: '成功訂位！'
  end
end
