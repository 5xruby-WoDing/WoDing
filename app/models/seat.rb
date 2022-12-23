# frozen_string_literal: true

class Seat < ApplicationRecord
  belongs_to :restaurant
  has_many :reservations, dependent: :destroy

  enum kind: %i[吧台 方桌 圓桌 包廂]
end
