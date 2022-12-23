# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[show reserve determine_occupied]
  before_action :find_seat, only: [:reserve]
  before_action :find_reservation_info, only: [:reserve]

  def show
    @seats = @restaurant.seats
    @content = @restaurant.content
    @opening_time = @restaurant.opening_times
  end

  def reserve
    @user = User.new
  end

  def determine_occupied
    user_id = params[:user_id]
    people = params[:people]
    reservated_date = params[:date].gsub(/\D/, '/').strip.to_date
    reservated_time = params[:time]

    over_capacity_seats = @restaurant.seats.select{|seat| seat.capacity < people}.map{|seat| seat.id}
    sum_of_seat = @restaurant.seats.size

    # occupied_seats = []

    # [{2=>"10:00"}, {3=>"12:30"}, {3=>"18:00"}, {3=>"13:30"}, {3=>"13:00"}]
    occupied_time = @restaurant.reservations.select{|reservation| reservation.arrival_date == reservated_date}
                    .reduce([]){|arr, reservation| arr << Hash[ reservation.arrival_time.strftime('%R'), reservation.seat_id]}

    each_time_occupied = occupied_time.flat_map(&:to_a).group_by(&:first).map {|k,v| Hash[k, v.size]}.flat_map(&:to_a)
    occupied_time = each_time_occupied.map{|time| time.first if time[1] >= sum_of_seat}.compact

    # @restaurant.reservations.each do |reservation|
    #   next unless reservated_date == reservation.arrival_date
    #   if reservated_time == reservation.arrival_time.strftime('%R')
    #     occupied_seats << reservation.seat_id
    #   end
    # end


    render json: {over_capacity_seats:, occupied_time:}
    # render json: { occupied_time:, occupied_seats:}
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def find_seat
    @seat = Seat.find(params[:seat_id])
  end

  def find_reservation_info
    @adult_quantity = params[:adult_quantity]
    @child_quantity = params[:child_quantity]
    @arrival_date = params[:arrival_date]
    @arrival_time = params[:arrival_time]
  end
end
