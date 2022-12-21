# frozen_string_literal: true

module Backstage
  class ReservationsController < ApplicationController
    before_action :authenticate_manager!
    before_action :find_reservation_id, only: %i[finish note]

    def finish
      @reservation = Reservation.find_by!(id: params[:id])
      @reservation.cancel! if @reservation.may_cancel?

      redirect_to backstage_restaurant_path(@reservation.restaurant), notice: '成功結束訂單'
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

    def find_reservation_id
      @reservation = Reservation.find_by!(id: params[:id])
    end
  end
end
