class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :seat

  validates :name, presence: true
  validates :phone, presence: true
  validates :serial, presence: true

  before_validation :generate_serial

  enum gender: [:男性, :女性, :其他]

  private
  def generate_serial
    self.serial = SecureRandom.alphanumeric(12) 
  end 

end
