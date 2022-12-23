# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :seat
  has_many :manager_reservations
  has_many :be_noted_managers, through: :manager_reservations, source: :manager

  include Gender
  include AASM

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
    state :reserved, :cancelled

    event :reserve do
      transitions from: :pending, to: :reserved
    end

    event :cancel do
      transitions from: %i[reserved pending], to: :cancelled
    end
  end

  private

  def generate_serial
    self.serial = SecureRandom.alphanumeric(12)
  end
end
