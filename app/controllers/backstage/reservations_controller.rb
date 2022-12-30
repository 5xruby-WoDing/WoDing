# frozen_string_literal: true

module Backstage
  class ReservationsController < Backstage::RestaurantsController
    before_action :find_reservation, only: %i[cancel note complete qrscan]
    before_action :find_restaurant, only: %i[index]

    def index
      @reservations = Reservation.includes(:seat,
                                           :restaurant,
                                           :manager_reservations).where(restaurant_id: @restaurant).references(:reservation)
      @current_reservatoin = @reservations.current_reservations

      @off_days = OffDay.includes(:restaurant).where(restaurant_id: @restaurant).references(:off_day).map{|off_day| off_day.off_day}

      @reserved = @current_reservatoin.reservations_state('reserved').count
      @completed = @current_reservatoin.reservations_state('completed').count
      @cancelled = @current_reservatoin.reservations_state('cancelled').count

      @q = @reservations.ransack(params[:q])
      @reservations = @q.result
    end

    def cancel
      @reservation.cancel! if @reservation.may_cancel?
      redirect_to backstage_restaurant_reservations_path(@reservation.restaurant_id), notice: '完成報到'
    end

    def complete
      @reservation.completed! if @reservation.may_completed?
      redirect_to backstage_restaurant_reservations_path(@reservation.restaurant_id), notice: '已取消'
    end

    def qrscan
      if @reservation.may_completed?
        @reservation.completed! 
        render json: {message: "success", reservation: @reservation, seat: @reservation.seat}
      else
        render json: {message: "fail", reservation: @reservation, seat: @reservation.seat}
      end            
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

    def statistics
      restaurant = Restaurant.find(params[:id])
      reservation = restaurant.reservations.where(arrival_date: params[:date])
      sum = reservation.size
      sum_of_people = reservation.reduce([]) { |arr, r| arr << (r.adult_quantity + r.child_quantity) }.sum
      render json: { sum:, sum_of_people: }
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
