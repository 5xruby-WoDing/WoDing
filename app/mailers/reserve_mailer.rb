class ReserveMailer < ApplicationMailer
  
  def reserve_notify(reservation)
    @reservation = reservation
    mail to: reservation.email, subject: "您的訂單資料，有提供QR-CODE，可以存取該圖片用做紀錄訂單資訊： "
  end

end
