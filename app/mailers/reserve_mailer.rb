# frozen_string_literal: true

class ReserveMailer < ApplicationMailer
  def reserve_notify(reservation)
    @reservation = reservation

    qr = RQRCode::QRCode.new("localhost:3000/reservations/#{reservation.serial}/checkout", size: 10, level: :h)
    attachments.inline['qr.png'] = {
      mime_type: 'image/png',
      content: qr.as_png.to_s
    }

    mail to: reservation.email, subject: '您的訂單資料，有提供QR-CODE，可以存取該圖片用做紀錄訂單資訊： '
  end
end