class RestaurantsController < ApplicationController

  before_action :find_restaurant, only: [:show, :reserve, :determine_time]
  before_action :find_seat_id, only: [:reserve]
  before_action :find_reservation_info, only: [:reserve]

  def show
    @seats = @restaurant.seats
  end

  def reserve
    @user = User.new
  end 

  def determine_time
    @date = params[:date].gsub(/月/, '/' ).gsub(/日/, '').to_date
    reservation_list = []
    @restaurant.reservations.each do |reservation|
      if reservation.arrival_date == @date
        reservation_list << reservation
      end
    end

    render json: {date: @date, reservations: reservation_list}
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
