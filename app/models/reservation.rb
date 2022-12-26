# frozen_string_literal: true

class Reservation < ApplicationRecord
  include Gender
  include AASM

  belongs_to :user
  belongs_to :restaurant
  belongs_to :seat
  has_many :manager_reservations
  has_many :be_noted_managers, through: :manager_reservations, source: :manager

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :serial, presence: true
  validates :arrival_time, presence: true
  validates :child_quantity, presence: true
  validates :arrival_date, presence: true

  before_validation :generate_serial

  aasm column: 'state', no_direct_assignment: true do
    state :pending, initial: true
    state :reserved, :cancelled, :compeleted

    event :reserve do
      transitions from: :pending, to: :reserved
    end

    event :cancel do
      transitions from: %i[reserved pending], to: :cancelled
    end

    event :compeleted, :after_commit => :occupied  do
      transitions from: :reserved, to: :compeleted do
        guard do
          self.seat.vacant?
        end
      end
    end
  end

  private

  def generate_serial
    self.serial = SecureRandom.alphanumeric(12)
  end

  def occupied
    self.seat.occupied!
  end
end