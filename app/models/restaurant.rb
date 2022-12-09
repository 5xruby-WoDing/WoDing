class Restaurant < ApplicationRecord
  acts_as_paranoid
  
  validates :title, presence: true
  validates :address, presence: true
  validates :tel, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :manager
  has_many :seats

  has_many :reservations
end
