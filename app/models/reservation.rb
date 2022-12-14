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
  validates :serial, presence: true, uniqueness: true
  validates :arrival_time, presence: true
  validates :child_quantity, presence: true
  validates :arrival_date, presence: true

  before_validation :generate_serial

  scope :before_today, -> { where('arrival_date < ?', Date.today) }
  scope :current_reservations, -> { where('arrival_date >= ?', Date.today) }
  scope :today_reservations, -> { where('arrival_date = ?', Date.today) }
  scope :when_reservations, -> (date){ where('arrival_date = ?', date) }

  scope :reserved, -> { where(state: 'reserved') }
  scope :completed, -> { where(state: 'completed') }
  scope :cancelled, -> { where(state: 'cancelled') }
  scope :not_cancelled, -> { where.not(state: 'cancelled') }
  scope :reservations_date, ->(date) { where('arrival_date =?', date) }

  scope :morning, -> { where('arrival_time <=?', Time.new.noon) }
  scope :afternoon, -> { where('arrival_time >?', Time.new.noon) }

  def self.people_count(date)
    if when_reservations(date).not_cancelled.blank?
      0
    else
     when_reservations(date).not_cancelled.pluck('SUM(adult_quantity), SUM(child_quantity)').flatten.sum
    end
  end

  def self.reservations_number(date)
    reservations_date(date).not_cancelled.size
  end

  def self.completed_number
    today_reservations.completed.count
  end

  def self.reserved_number
    today_reservations.reserved.count
  end
  
  def self.cancelled_number
    today_reservations.cancelled.count
  end

  def self.morning_number(date)
    reservations_date(date).not_cancelled.morning.count
  end

  def self.afternoon_number(date)
    reservations_date(date).not_cancelled.afternoon.count
  end

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
