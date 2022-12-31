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
  validates :phone, presence: true, format: { with: /\d+{10}/ }
  validates :email, presence: true
  validates :serial, presence: true
  validates :arrival_time, presence: true
  validates :child_quantity, presence: true
  validates :arrival_date, presence: true

  before_validation :generate_serial

  scope :current_reservations, -> { where('arrival_date >= ?', Date.today) }
  scope :today_reservations, -> { where('arrival_date = ?', Date.today) }
  scope :reserved, -> { where(state: 'reserved') }
  scope :completed, -> { where(state: 'completed') }
  scope :cancelled, -> { where(state: 'cancelled') }
  scope :not_cancelled, -> { where.not(state: 'cancelled') }
  scope :reservations_date, -> (date){where('arrival_date =?', date)}

  aasm column: 'state', no_direct_assignment: true do
    state :pending, initial: true
    state :reserved, :cancelled, :completed

    event :reserve do
      transitions from: :pending, to: :reserved
    end

    event :cancel do
      transitions from: %i[reserved pending], to: :cancelled
    end

    event :completed, after_commit: :occupied do
      transitions from: :reserved, to: :completed do
        guard do
          seat.vacant?
        end
      end
    end
  end

  private

  def generate_serial
    self.serial = SecureRandom.alphanumeric(12)
  end

  def occupied
    seat.occupied!
  end
end
