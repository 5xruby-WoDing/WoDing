# frozen_string_literal: true

module Backstage
  class OpeningTimesController < Backstage::ManagersController
    before_action :find_restaurant, only: %i[create]
    before_action :find_opening_time, only: %i[edit update destroy]

    def create
      @opening_time = @restaurant.opening_times.new(params_opening_time)
      return unless @opening_time.save

      redirect_to backstage_restaurant_path(@restaurant.id)
    end

    def edit; end

    def update
      return unless @opening_time.update(params_opening_time)

      redirect_to backstage_restaurant_path(@opening_time.restaurant_id)
    end

    def destroy
      @opening_time.destroy
      redirect_to backstage_restaurant_path(@opening_time.restaurant_id)
    end

    private

    def params_opening_time
      params.require(:opening_time).permit(:title, :opening_time, :closed_time)
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def find_opening_time
      @opening_time = OpeningTime.find(params[:id])
    end
  end
end
