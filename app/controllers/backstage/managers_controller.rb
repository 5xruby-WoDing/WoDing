# frozen_string_literal: true

module Backstage
  class ManagersController < ApplicationController
    before_action :authenticate_manager!

    layout 'backstage'

    def show
      @restaurants = current_manager.restaurants
      @reservations = Reservation.all
    end
  end
end
