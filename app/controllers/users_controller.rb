# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_restaurant, only: [:create]
  before_action :find_seat, only: [:create]
  before_action :validation_params, only: [:create]

  def create
    @user = User.new(user_params)

    if @user.save
      if Reservation.exists?(arrival_date: @date, arrival_time: @time, seat_id: @seat_id)
        redirect_to waring_restaurants_path
      else
        reservation = Reservation.create!(reservation_params)
        if reservation.may_reserve? && reservation.seat.deposit.zero?
          reservation.reserve!
          ReserveMailJob.perform_later(reservation)
        else
          DepositMailJob.perform_later(reservation)
        end
        redirect_to checkout_reservation_path(id: reservation.serial)
      end
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

  def user_params
    params.require(:user).permit(:name, :email, :phone, :gender)
  end

  def reservation_params
    params.require(:user).permit(:name, :email, :phone, :gender, :arrival_time,
                                 :adult_quantity, :child_quantity, :arrival_date, :end_time)
          .merge(seat: @seat, restaurant: @restaurant, user: @user)
  end

  def validation_params
    @time = Time.parse(params[:user][:arrival_time])
    @date = params[:user][:arrival_date]
    @seat_id = params[:seat_id]
  end
end
