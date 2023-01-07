# frozen_string_literal: true

module Backstage
  class OpeningTimesController < Backstage::RestaurantsController
    before_action :find_restaurant, only: %i[create index]
    before_action :find_opening_time, only: %i[edit update destroy]

    def index
      @opening_time = OpeningTime.new
      @opening_times = @restaurant.opening_times.includes(:restaurant)

      @off_days = @restaurant.off_days.includes(:restaurant)
      @off_day = OffDay.new

      @week = (Date.today.beginning_of_week..Date.today.end_of_week)
    end

    def create
      opening_time = Time.new(  
        params[:opening_time]['opening_time(1i)'].to_i,
        params[:opening_time]['opening_time(2i)'].to_i,
        params[:opening_time]['opening_time(3i)'].to_i,
        params[:opening_time]['opening_time(4i)'].to_i,
        params[:opening_time]['opening_time(5i)'].to_i
      )

      closed_time = Time.new(
        params[:opening_time]['closed_time(1i)'].to_i,
        params[:opening_time]['closed_time(2i)'].to_i,
        params[:opening_time]['closed_time(3i)'].to_i,
        params[:opening_time]['closed_time(4i)'].to_i,
        params[:opening_time]['closed_time(5i)'].to_i
      )

      if opening_time < closed_time
        @opening_time = @restaurant.opening_times.new(opening_time_params)
        return unless @opening_time.save
      end

    end

    def edit
      render layout: 'backstage'
    end

    def update
      return unless @opening_time.update(opening_time_params)

      redirect_to backstage_restaurant_opening_times_path(@opening_time.restaurant), notice: '已更新時段'
    end

    def destroy
      @opening_time.destroy
    end

    private

    def opening_time_params
      params.require(:opening_time).permit(:opening_time, :closed_time)
    end

    def find_restaurant
      @restaurant = current_manager.restaurants.find(params[:restaurant_id])
    end

    def find_opening_time
      @opening_time = OpeningTime.find(params[:id])
    end
  end
end
