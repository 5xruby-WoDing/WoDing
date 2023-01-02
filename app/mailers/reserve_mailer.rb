# frozen_string_literal: true

class ReserveMailer < ApplicationMailer
  def reserve_notify(reservation)
    @reservation = reservation
    # @cancel_url = "http://localhost:3000/reservations/#{reservation.serial}/cancel"
    @cancel_url = "#{ENV['WEB_DOMAIN']}/reservations/#{reservation.serial}/cancel"
    
    # qr = RQRCode::QRCode.new("http://localhost:3000/backstage/reservations/#{reservation.id}/qrscan", size: 10, level: :h)    
    qr = RQRCode::QRCode.new("#{ENV['WEB_DOMAIN']}/backstage/reservations/#{reservation.id}/qrscan", size: 10, level: :h)    
    
    png = qr.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 250
    )

    IO.binwrite("tmp/cache/#{reservation.serial}.png", png.to_s)
    attachments.inline['qr.png'] = File.read("#{Rails.root}/tmp/cache/#{reservation.serial}.png")

    mail to: reservation.email, subject: '您的訂單資料，有提供QR-CODE，可以存取該圖片用做紀錄訂單資訊： '
  end
end
