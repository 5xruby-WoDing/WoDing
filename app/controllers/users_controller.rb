class UsersController < ApplicationController
    
  before_action :find_restaurant_id, only: [:create]
  before_action :find_seat_id, only: [:create]

  def create

    @user = User.new(params_user)

    if @user.save
      reservation = Reservation.create!(params_reservation)

      if reservation.may_reserve? && reservation.seat.deposit == 0
        reservation.reserve!
      end

      ReserveMailJob.perform_later(reservation)

      redirect_to checkout_reservation_path(id: reservation.serial), notice: "User資料存入、order建立"
    else
      render "restaurants/reserve"
    end
  end

  private
  def find_restaurant_id
    @restaurant = Restaurant.find_by!(id: params[:restaurant_id])
  end

  def find_seat_id
    @seat = Seat.find_by!(id: params[:seat_id])
  end

  def params_user
    params.require(:user).permit(:name, :email, :phone, :gender)
  end

  def params_reservation
    params.require(:user).permit(:name, :email, :phone, :gender, :arrival_time, :adult_quantity, :child_quantity, :arrival_date, :end_time).merge(seat: @seat, restaurant: @restaurant, user: @user) 
  end
  
end