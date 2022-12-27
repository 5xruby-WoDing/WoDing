# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_restaurant, only: [:create]
  before_action :find_seat, only: [:create]

  def create
    @user = User.new(params_user)

    if @user.save
      reservation = Reservation.create!(params_reservation)
      reservation.reserve! if reservation.may_reserve? && reservation.seat.deposit.zero?

      ReserveMailJob.perform_later(reservation)

      redirect_to checkout_reservation_path(id: reservation.serial)
    else
      render 'restaurants/reserve'
    end
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def find_seat
    @seat = Seat.find(params[:seat_id])
  end

  def params_user
    params.require(:user).permit(:name, :email, :phone, :gender)
  end

  def params_reservation
    params.require(:user).permit(:name, :email, :phone, :gender, :arrival_time,
                                 :adult_quantity, :child_quantity, :arrival_date, :end_time)
          .merge(seat: @seat, restaurant: @restaurant, user: @user)
  end
end
