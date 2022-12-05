class Restaurant < ApplicationRecord
  acts_as_paranoid
  
  validates :title, presence: true
  validates :address, presence: true
  validates :tel, presence: true

  belongs_to :manager
end
