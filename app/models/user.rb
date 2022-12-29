# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reservations

  include Gender

  validates :name, presence: true
  validates :phone, presence: true, format: { with: /\d+{10}/ }
  validates :email, presence: true
end
