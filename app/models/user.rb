class User < ApplicationRecord
    has_many :reservations
    enum gender: [:男性, :女性, :其他]

    validates :name, presence: true
    validates :phone, presence: true
end
