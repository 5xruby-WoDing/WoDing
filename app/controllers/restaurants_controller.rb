# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i[show reserve occupied]
  before_action :find_seat_id, only: [:reserve]

  def show
    @seats = @restaurant.seats
    @content = @restaurant.content
    @opening_time = @restaurant.opening_times
  end

  def reserve
    @user = User.new

    arrival_date = (params[:arrival_date]).gsub(/\D/, '/').strip.to_date.to_s

    @key = SecureRandom.urlsafe_base64
    $redis.hset @key, { arrival_time: (params[:arrival_time]), 
                      arrival_date: (arrival_date),
                      seat_id: (params[:seat_id]), 
                    }
    $redis.sadd('all_key', @key)
  
  end

  def timeout
    p key = params[:key]
    puts '+'*200
    $redis.del(key)
  end

  def occupied
    user_id = params[:user_id]
    people = params[:people]
    reservated_date = params[:date].gsub(/\D/, '/').strip.to_date
    reservated_time = params[:time]
    
    over_capacity_seats = @restaurant.seats.select{|seat| seat.capacity < people}.map{|seat| seat.id}
    sum_of_seat = @restaurant.seats.size

    arrival_date = @restaurant.reservations.select{|reservation| reservation.arrival_date == reservated_date}
    # [{2=>"10:00"}, {3=>"12:30"}, {3=>"18:00"}, {3=>"13:30"}, {3=>"13:00"}]
    occupied_time = arrival_date.reduce([]){|arr, reservation| arr << Hash[ reservation.arrival_time.strftime('%R'), reservation.seat_id]}
    occupied_seats = arrival_date.select{|reservation| reservated_time == reservation.arrival_time.strftime('%R')}
    each_time_occupied = occupied_time.flat_map(&:to_a).group_by(&:first).map {|k,v| Hash[k, v.size]}.flat_map(&:to_a)
    occupied_time = each_time_occupied.map{|time| time.first if time[1] >= sum_of_seat}.compact

    occupied_seats_id = occupied_seats.map{|reservation| reservation.seat_id}

    all_keys = $redis.smembers('all_key')
    all_keys = all_keys.map do |key|
       $redis.hgetall(key)
    end

    render json: {over_capacity_seats:, occupied_time:, occupied_seats_id:, all_keys:}
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def find_seat_id
    @seat = Seat.find_by!(id: params[:seat_id])
  end
end
