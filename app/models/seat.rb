class Seat < ApplicationRecord

  include AASM

  belongs_to :restaurant
  has_many :reservations

  enum kind: [:吧台, :方桌, :圓桌, :包廂]

  aasm column: "state", no_direct_assignment: true do
    state :vacancy, initial: true
    state :closed

    event :close do
      transitions from: :vacancy, to: :closed
    end

    event :open do
      transitions from: :closed, to: :vacancy
    end

  end
end
