# frozen_string_literal: true

class ReserveMailJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    ReserveMailer.reserve_notify(reservation).deliver

    sms_client = Twsms2::Client.new(username: ENV['TWSMS_ACCOUNT'], password: ENV['TWSMS_PASSWORD'])
    sms_client.send_message to: "#{reservation.phone}", content: "成功訂位！#{reservation.restaurant.title}，訂位的日期#{reservation.arrival_date.strftime}、時間#{reservation.arrival_time.strftime('%R')}、地址#{reservation.restaurant.address}"
  end
end
