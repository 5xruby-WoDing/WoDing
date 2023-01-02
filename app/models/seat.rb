# frozen_string_literal: true

class Seat < ApplicationRecord
  include AASM
  acts_as_paranoid

  validates :title, presence: true

  belongs_to :restaurant
  has_many :reservations, dependent: :destroy

  enum kind: %i[吧台 方桌 圓桌 包廂]

  scope :seat_occupied, -> {where(state: 'occupied')}
  scope :seat_capacity, -> (people){where('capacity < ?', people)}

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
