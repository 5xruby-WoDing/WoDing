# frozen_string_literal: true

module Backstage
  class OffDaysController < Backstage::RestaurantsController
    before_action :find_restaurant, only: %i[create]
    before_action :find_off_day, only: %i[destroy]
    def create
      @off_day = @restaurant.off_days.new(off_day_params)
      if @off_day.save
        redirect_to backstage_restaurant_opening_times_path(@off_day.restaurant_id), notice: '已新增公休日'
      else
        redirect_to backstage_restaurant_opening_times_path(@restaurant), notice: '錯誤'
      end
    end

    def destroy
      @off_day.destroy
      redirect_to backstage_restaurant_opening_times_path(@off_day.restaurant_id), notice: '已刪除公休日'
    end

    private

    def off_day_params
      params.required(:off_day).permit(:off_day)
    end

    def find_restaurant
      @restaurant = current_manager.restaurants.find(params[:restaurant_id])
    end

    def find_off_day
      @off_day = OffDay.find(params[:id])
    end
  end
end
