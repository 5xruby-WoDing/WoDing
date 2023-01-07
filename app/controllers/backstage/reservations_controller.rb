# frozen_string_literal: true

module Backstage
  class ReservationsController < Backstage::RestaurantsController
    before_action :find_reservation, only: %i[note]
    before_action :find_restaurant, only: %i[index history statistics]
    before_action :find_off_days, only: %i[index]
    before_action :find_reservation_serial, only: %i[cancel qrscan complete]

    def index
      today = Date.today
      reservations = @restaurant.reservations.includes(:seat, :manager_reservations)
      current_reservations = reservations.current_reservations.order(arrival_time: :asc)

      @morning = current_reservations.morning
      @afternoon = current_reservations.afternoon

      @q = reservations.ransack(params[:q])
      @reservations = @q.result

      @today_reservations_number = reservations.reservations_number(today)

      @people_number = reservations.people_count(today)
      @completed_number = reservations.completed_number
      @reserved_number = reservations.reserved_number
      @cancelled_number = reservations.cancelled_number
    end
    
    def cancel            
      @reservation.cancel! if @reservation.may_cancel?
      redirect_to backstage_restaurant_reservations_path(@reservation.restaurant_id), notice: '已取消'
    end

    def complete                 
      @reservation.completed! if @reservation.may_completed?
      redirect_to backstage_restaurant_reservations_path(@reservation.restaurant_id), notice: '完成報到'
    end

    def qrscan
      if @reservation.may_completed?
        @reservation.completed!
        render json: { message: 'success', reservation: @reservation, seat: @reservation.seat,
                       id: @reservation.restaurant_id }
      else
        render json: { message: 'fail', reservation: @reservation, seat: @reservation.seat }
      end
    end

    def note
      if current_manager.noted_important_reservation?(@reservation)
        current_manager.noted_important_reservations.delete(@reservation)
        render json: { status: 'not be noted', manager: current_manager, reservation: @reservation }
      else
        current_manager.noted_important_reservations << @reservation
        render json: { status: 'has been noted', manager: current_manager, reservation: @reservation }
      end
    end

    def statistics
      date = params[:date]
      reservation = @restaurant.reservations
      sum = reservation.reservations_number(date)
      sum_of_people = reservation.people_count(date)

      morning_number = reservation.morning_number(date)
      afternoon_number = reservation.afternoon_number(date)
      render json: { sum:, sum_of_people:, morning_number:, afternoon_number:}
    end

    def history
      @reservations = @restaurant.reservations.before_today
      @q = @reservations.ransack(params[:q])
      @reservations = @q.result
    end

    private

    def find_reservation
      @reservation = Reservation.find(params[:id])
    end

    def find_reservation_serial
      @reservation = Reservation.find_by!(serial: params[:id])
    end

    def find_restaurant
      @restaurant = current_manager.restaurants.find(params[:restaurant_id])
    end

  end
end
