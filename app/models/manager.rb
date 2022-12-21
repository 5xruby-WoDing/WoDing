# frozen_string_literal: true

class Manager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  include Gender

  # devise mailer active job
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  has_many :restaurants
  has_many :manager_reservations
  has_many :noted_important_reservations, through: :manager_reservations, source: :reservation

  def noted_important_reservation?(reservation)
    noted_important_reservations.include?(reservation)
  end
end
