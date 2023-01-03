# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[show reserve occupied]
  before_action :find_seat_id, only: [:reserve]

  def show
    @seats = Seat.includes(:restaurant).where(restaurant_id: @restaurant).references(:seat)
    @content = @restaurant.content
    @opening_time = OpeningTime.includes(:restaurant).where(restaurant_id: @restaurant).references(:opening_time).order(opening_time: :asc)
    @key = SecureRandom.urlsafe_base64
    @tags = @restaurant.tags
    @off_days = OffDay.includes(:restaurant).where(restaurant_id: @restaurant).references(:off_day).map do |off_day|
      off_day.off_day
    end
  end

  def reserve
    @user = User.new
    @key = params[:key]
    @end_time = params[:arrival_time].to_time + @restaurant.dining_time.minutes
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
    restaurant = Restaurant.find(params[:id])

    over_capacity_seats = @restaurant.seats.seat_capacity(people).map(&:id)
    sum_of_seat = @restaurant.seats.size
    arrival_date = @restaurant.reservations.reservations_date(reservated_date).not_cancelled

    # [{7=>["13:00", "13:30", "14:00", "14:30"]}]
    occupied = arrival_date.each.reduce([]) do |arr, reservation|
      arr << Hash[reservation.seat_id, (reservation.arrival_time.to_i..reservation.end_time.to_i).step(restaurant.interval_time.minutes).reduce([]) do |array, time|
                                         array << Time.at(time).strftime('%R')
                                       end]
    end

    # [[7, ["13:00", "13:30", "14:00", "14:30"]]]
    occupied_seats = occupied.flat_map(&:to_a).group_by(&:first).map do |k, v|
      [k, v.flatten.delete_if { |i| i.is_a?(Integer) }]
    end

    # [[["13:00", "13:30", "14:00", "14:30"], 1]]
    each_time_occupied = occupied.flat_map(&:to_a).group_by(&:last).map do |k, v|
      Hash[k, v.size]
    end.flat_map(&:to_a)

    # ["10:00", "10:30", "11:00"] 客滿時間
    occupied_time = each_time_occupied.map { |time| time.first if time[1] >= sum_of_seat }.compact.flatten

    all_keys = $redis.smembers('all_key')
    all_keys = all_keys.map do |key|
      $redis.hgetall(key)
    end

    render json: { over_capacity_seats:, occupied_time:, occupied_seats:, all_keys: }
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def find_seat_id
    @seat = Seat.find_by!(id: params[:seat_id])
  end
end
