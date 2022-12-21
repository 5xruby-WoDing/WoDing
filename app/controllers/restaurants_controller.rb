# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[show reserve determine_occupied]
  before_action :find_seat_id, only: [:reserve]
  before_action :find_reservation_info, only: [:reserve]

  def show
    @seats = @restaurant.seats
    @content = @restaurant.content
  end

  def reserve
    @user = User.new
  end

  def determine_occupied
    people = params[:people]
    reservated_date = params[:date].gsub(/月/, '/').gsub(/日/, '').to_date
    reservated_time = params[:time]

    sum_of_seat = @restaurant.seats.size
    reservated_list = []
    occupied_seats = []

    @restaurant.reservations.each do |reservation|
      next unless reservated_date == reservation.arrival_date

      reservated_list << [reservation.arrival_time.strftime('%R'), reservation.seat_id]

      occupied_seats << reservation.seat_id if reservated_time == reservation.arrival_time.strftime('%R')
    end

    @restaurant.seats.each { |c| occupied_seats << c.id if c.capacity < people }

    occupied_time = reservated_list.group_by { |h| h[0] }.keys
    occupied_seat_total = reservated_list.group_by { |h| h[0] }.map { |_k, v| v.size }
    each_time_total_occupied = Hash[occupied_time.zip(occupied_seat_total)]
    occupied_time = each_time_total_occupied.map { |el| el.first if el[1] >= sum_of_seat }.compact

    render json: { occupied_time:, occupied_seats:, people: }
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
