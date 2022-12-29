module Backstage
  class OffDaysController < Backstage::RestaurantsController
    before_action :find_restaurant, only: %i[create]
    def create
      @off_day = @restaurant.off_days.new(params_off_day)
      if @off_day.save
        redirect_to backstage_restaurant_opening_times_path(@restaurant), notice: 'ok'
      else
        redirect_to backstage_restaurant_opening_times_path(@restaurant), notice: 'asdasdas'
      end
    end

    def destroy
      off_day = OffDay.find(params[:id])
      off_day.destroy
      redirect_to backstage_restaurant_opening_times_path(off_day.restaurant_id), notice: 'ok'
    end

    private
    def params_off_day
      params.required(:off_day).permit(:off_day)
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

  end
end