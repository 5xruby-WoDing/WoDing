# frozen_string_literal: true

module Backstage
  class SeatsController < Backstage::RestaurantsController
    before_action :find_restaurant, only: %i[index create]
    before_action :find_seat, only: %i[show edit update destroy vacant occupied]

    def index
      @seats = @restaurant.seats.order(title: :asc)
      @seat = Seat.new
    end

    def create
      @seat = @restaurant.seats.new(params_seat)

      if @seat.save
        redirect_to backstage_restaurant_seats_path(@restaurant)
      end
    end

    def edit
      render :layout => 'backstage'
    end

    def update
      if @seat.update(params_seat)
        redirect_to backstage_restaurant_seats_path(@seat.restaurant_id)
      else
        render :edit
      end
    end

    def destroy
      @seat.destroy
      redirect_to backstage_restaurant_seats_path(@seat.restaurant_id)
    end

    def vacant
      @seat.occupied! if @seat.may_occupied?
      redirect_to backstage_restaurant_seats_path(@seat.restaurant_id)
    end

    def occupied
      @seat.vacant! if @seat.may_vacant?
      redirect_to backstage_restaurant_seats_path(@seat.restaurant_id)
    end

    private

    def find_restaurant
      @restaurant = current_manager.restaurants.find(params[:restaurant_id])
    end

    def params_seat
      params.require(:seat).permit(:kind, :capacity, :deposit, :state, :title)
    end

    def find_seat
      @seat = Seat.find(params[:id])
    end
  end
end
