# frozen_string_literal: true

module Backstage
  class SeatsController < Backstage::RestaurantsController
    before_action :find_restaurant, only: %i[index create]
    before_action :find_seat, only: %i[show edit update destroy vacant occupied]

    def index
      seats = @restaurant.seats.includes(:restaurant).order(title: :asc)

      @booth = seats.booth
      @round_table = seats.round_table
      @square_table = seats.square_table

      @vacant = seats.vacant.count
      @occupied = seats.occupied.count

      @seat = Seat.new
    end

    def create
      @seat = @restaurant.seats.new(seat_params)

      return unless @seat.save

      redirect_to backstage_restaurant_seats_path(@restaurant), notice: '座位新增成功'
    end

    def edit
      render layout: 'backstage'
    end

    def update
      if @seat.update(seat_params)
        redirect_to backstage_restaurant_seats_path(@seat.restaurant_id), notice: '座位更新成功'
      else
        render :edit
      end
    end

    def destroy
      @seat.destroy
      redirect_to backstage_restaurant_seats_path(@seat.restaurant_id), notice: '座位已刪除'
    end

    def vacant
      @seat.occupied! if @seat.may_occupied?
      redirect_to backstage_restaurant_seats_path(@seat.restaurant_id), notice: '狀態變更'
    end

    def occupied
      @seat.vacant! if @seat.may_vacant?
      redirect_to backstage_restaurant_seats_path(@seat.restaurant_id), notice: '狀態變更'
    end

    private

    def find_restaurant
      @restaurant = current_manager.restaurants.find(params[:restaurant_id])
    end

    def seat_params
      params.require(:seat).permit(:kind, :capacity, :deposit, :state, :title)
    end

    def find_seat
      @seat = Seat.find(params[:id])
    end
  end
end
