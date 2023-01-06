# frozen_string_literal: true

module Backstage
  class ReservationsController < Backstage::RestaurantsController
    before_action :find_reservation, only: %i[note]
    before_action :find_restaurant, only: %i[index history]
    before_action :find_off_days, only: %i[index]
    before_action :find_reservation_serial, only: %i[cancel qrscan complete]

    def index
      reservations = @restaurant.reservations.includes(:seat, :manager_reservations)

      current_reservations = reservations.current_reservations.order(arrival_time: :asc)
      @today_reservations = reservations.today_reservations.not_cancelled

      @morning = current_reservations.moning
      @afternoon = current_reservations.afternoon

      @cancelled = reservations.today_reservations.cancelled

      @q = reservations.ransack(params[:q])
      @reservations = @q.result
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
        render json: { status: 'not be noted', manager: current_manager.id, reservation: @reservation.id }
      else
        current_manager.noted_important_reservations << @reservation
        render json: { status: 'has been noted', manager: current_manager.id, reservation: @reservation.id }
      end
    end

    def statistics
      reservation = Reservation.includes(:restaurant).where(restaurant_id: params[:id],
                                                            arrival_date: params[:date]).references(:reservation)
      sum = reservation.size
      sum_of_people = reservation.reduce(0) { |array, r| array += (r.adult_quantity + r.child_quantity) }
      render json: { sum:, sum_of_people: }
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
