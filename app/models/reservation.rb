class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :seat
  has_many :mark_reservations
  has_many :be_marked_managers, through: :mark_reservations, source: :manager

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
