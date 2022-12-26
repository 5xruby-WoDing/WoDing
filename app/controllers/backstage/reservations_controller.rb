# frozen_string_literal: true

module Backstage
  class ReservationsController < Backstage::ManagersController
    before_action :find_reservation, only: %i[cancel note compelete]
    before_action :find_restaurant, only: %i[index]

    def index
      
    end

    def cancel
      @reservation.cancel! if @reservation.may_cancel?
      redirect_to backstage_restaurant_path(@reservation.restaurant)
    end

    def compelete
      @reservation.compeleted! if @reservation.may_compeleted?
      redirect_to backstage_restaurant_path(@reservation.restaurant)
    end

    def note
      if current_manager.noted_important_reservation?(@reservation)
        current_manager.noted_important_reservations.delete(@reservation)
        render json: { status: 'not be noted', manager: current_manager.id, reservation: @reservation.id }
      else
        current_manager.noted_important_reservations << @reservation
        render json: { status: 'has been noted', manager: current_manager.id, reservation: @reservation.id }
      end
    end

    private

    def find_reservation
      @reservation = Reservation.find(params[:id])
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
  end
end
