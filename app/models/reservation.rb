class Reservation < ApplicationRecord

  include AASM

  belongs_to :user
  belongs_to :restaurant
  belongs_to :seat

  validates :name, presence: true
  validates :phone, presence: true
  validates :serial, presence: true

  before_validation :generate_serial

  enum gender: [:男性, :女性, :其他]



  
  aasm column: "state", no_direct_assignment: true do
    state :pending, initial: true
    state :reserved, :cancelled

    event :reserve, :after_commit => :close_seat do
      transitions from: :pending, to: :reserved do
        guard do
          self.seat.vacancy?
        end
      end
    end

    event :cancel, :after_commit => :open_seat do
      transitions from: :reserved, to: :cancelled do
        guard do
          self.seat.closed?
        end
      end
    end
    
  end



  private
  def generate_serial
    self.serial = SecureRandom.alphanumeric(12) 
  end 

  def close_seat
    self.seat.close!
  end

  def open_seat
    self.seat.open!
  end

end
