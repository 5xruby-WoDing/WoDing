class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :seat

  validates :name, presence: true
  validates :phone, presence: true

  enum gender: [:男性, :女性, :其他]
end
