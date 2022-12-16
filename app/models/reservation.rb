class Reservation < ApplicationRecord

  include AASM
  belongs_to :user
  belongs_to :restaurant
  belongs_to :seat

  include Gender

  validates :name, presence: true
  validates :phone, presence: true
  validates :serial, presence: true

  before_validation :generate_serial


  aasm column: "state", no_direct_assignment: true do
    state :pending, initial: true
    state :reserved, :cancelled

    event :reserve do
      transitions from: :pending, to: :reserved
    end

    event :cancel do
      transitions from: [:reserved, :pending], to: :cancelled
    end

  end

  private
  def generate_serial
    self.serial = SecureRandom.alphanumeric(12) 
  end 

end
