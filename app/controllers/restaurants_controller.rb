class RestaurantsController < ApplicationController

  before_action :find_restaurant, only: [:show, :reserve]
  before_action :find_seat_id, only: [:reserve]
  before_action :find_reservation_info, only: [:reserve]

  def show
    @seats = @restaurant.seats
  end

  def reserve
    @user = User.new
  end

  private
  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def find_seat_id
    @seat = Seat.find_by!(id: params[:seat_id])
  end

  def find_reservation_info
    @adult_quantity = params[:adult_quantity]
    @child_quantity = params[:child_quantity]
    @arrival_date = params[:arrival_date]
    @arrival_time = params[:arrival_time]
  end

end
