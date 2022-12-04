class Restaurant < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :manager
end
