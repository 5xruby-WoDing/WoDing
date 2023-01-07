# frozen_string_literal: true

class Seat < ApplicationRecord
  include AASM
  acts_as_paranoid

  validates :title, presence: true

  belongs_to :restaurant
  has_many :reservations, dependent: :destroy

  enum kind: %i[方桌 圓桌 包廂]

  scope :seat_occupied, -> { where(state: 'occupied') }
  scope :seat_vacant, -> { where(state: 'vacant') }
  scope :seat_capacity, ->(people) { where('capacity < ?', people) }
  scope :round_table, -> { where('kind = ?', 1) }
  scope :booth, -> { where('kind = ?', 2) }
  scope :square_table, -> { where('kind = ?', 0) }

  def self.occupied_number
    seat_occupied.count
  end

  aasm column: 'state', no_direct_assignment: true do
    state :vacant, initial: true
    state :occupied

    event :vacant do
      transitions from: :occupied, to: :vacant
    end

    event :occupied do
      transitions from: :vacant, to: :occupied
    end
  end
end
