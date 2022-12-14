class Reservation < ApplicationRecord

  acts_as_paranoid
  
  belongs_to :user
  belongs_to :restaurant
  belongs_to :seat

  include Gender

  validates :name, presence: true
  validates :phone, presence: true
  validates :serial, presence: true

  before_validation :generate_serial

  private
  def generate_serial
    self.serial = SecureRandom.alphanumeric(12) 
  end 

end
