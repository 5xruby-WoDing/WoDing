class Seat < ApplicationRecord

  belongs_to :restaurant
  has_many :reservations

  enum kind: [:吧台, :方桌, :圓桌, :包廂]

end
