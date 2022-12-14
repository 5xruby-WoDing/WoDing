class MarkReservation < ApplicationRecord
  belongs_to :manager
  belongs_to :reservation
end
