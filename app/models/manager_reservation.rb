 # frozen_string_literal: true

class ManagerReservation < ApplicationRecord
  belongs_to :manager
  belongs_to :reservation
end
