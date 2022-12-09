class UsersController < ApplicationController
    
  before_action :find_restaurant_id, only: [:create]
  before_action :find_seat_id, only: [:create]

  def create
    name = params[:name]
    email = params[:email]
    phone = params[:phone]
    gender = params[:gender]
    arrival_time = params[:arrival_time]
    adult_quantity = params[:adult_quantity]
    child_quantity = params[:child_quantity]

    @user = User.new(name: name, 
                     email: email, 
                     phone: phone, 
                     gender: gender)

    if @user.save
      reservation = Reservation.create!(name: name,
                                        email: email,
                                        phone: phone,
                                        gender: gender,
                                        arrival_time: arrival_time,
                                        adult_quantity: adult_quantity,
                                        child_quantity: child_quantity,
                                        seat_id: @seat.id,
                                        restaurant_id: @restaurant.id,
                                        user_id: @user.id,)

      redirect_to checkout_reservation_path(reservation), notice: "User資料存入、order建立"
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
  
end