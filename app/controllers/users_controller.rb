# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_restaurant, only: [:create]
  before_action :find_seat, only: [:create]
  before_action :params_validation, only: [:create]

  def create
    @user = User.new(params_user)

    if @user.save
      if Reservation.reservations_date(@date).time_validation(@time).seat_validation(@seat_id).reserved.any?
        redirect_to waring_restaurants_path
      else
        reservation = Reservation.create!(params_reservation)
        reservation.reserve! if reservation.may_reserve? && reservation.seat.deposit.zero?
      end

      if reservation.seat.deposit.zero?
        ReserveMailJob.perform_later(reservation)
      else
        DepositMailJob.perform_later(reservation)
      end
      
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

  def params_validation
    @time = Time.parse(params[:user][:arrival_time])
    @date = params[:user][:arrival_date]
    @seat_id = params[:seat_id]
  end
end
