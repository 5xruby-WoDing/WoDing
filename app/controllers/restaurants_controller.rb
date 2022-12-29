# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[show reserve occupied]
  before_action :find_seat_id, only: [:reserve]

  def show
    @seats = Seat.includes(:restaurant).where(restaurant_id: @restaurant).references(:seat)
    @content = @restaurant.content
    @opening_time = OpeningTime.includes(:restaurant).where(restaurant_id: @restaurant).references(:opening_time)
    @key = SecureRandom.urlsafe_base64
    @tags = @restaurant.tags
    @off_days = OffDay.includes(:restaurant).where(restaurant_id: @restaurant).references(:off_day).map{|off_day| off_day.off_day}
  end

  def reserve
    @user = User.new
    @key = params[:key]

    $redis.hset(@key, { arrival_time: params[:arrival_time],
                        arrival_date: params[:arrival_date],
                        seat_id: params[:seat_id] })
    $redis.expire(@key, '300')
    $redis.sadd('all_key', @key)
  end

  def out
    key = params[:key]
    $redis.del(key)
  end

  def occupied
    people = params[:people]
    reservated_date = params[:date].to_date
    reservated_time = params[:time]

    over_capacity_seats = @restaurant.seats.select { |seat| seat.capacity < people }.map { |seat| seat.id }
    sum_of_seat = @restaurant.seats.size

    arrival_date = @restaurant.reservations.select { |reservation| reservation.arrival_date == reservated_date && reservation.state != 'cancelled'}
    # [{2=>"10:00"}, {3=>"12:30"}, {3=>"18:00"}, {3=>"13:30"}, {3=>"13:00"}]
    occupied_time = arrival_date.each.reduce([]) do |arr, reservation|
      arr << Hash[reservation.arrival_time.strftime('%R'), reservation.seat_id]
    end
    occupied_seats = arrival_date.select { |reservation| reservated_time == reservation.arrival_time.strftime('%R') }
    each_time_occupied = occupied_time.flat_map(&:to_a).group_by(&:first).map do |k, v|
      Hash[k, v.size]
    end.flat_map(&:to_a)
    occupied_time = each_time_occupied.map { |time| time.first if time[1] >= sum_of_seat }.compact

    occupied_seats_id = occupied_seats.map { |reservation| reservation.seat_id }

    all_keys = $redis.smembers('all_key')
    all_keys = all_keys.map do |key|
      $redis.hgetall(key)
    end

    render json: { over_capacity_seats:, occupied_time:, occupied_seats_id:, all_keys: }
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def find_seat_id
    @seat = Seat.find_by!(id: params[:seat_id])
  end
end
