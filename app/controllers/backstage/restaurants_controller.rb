# frozen_string_literal: true

module Backstage
  class RestaurantsController < Backstage::ManagersController
    before_action :find_restaurant, only: %i[show edit update destroy]
    layout 'restaurant_backstage'

    def new
      @restaurant = current_manager.restaurants.new
       render layout: 'backstage'
    end

    def create
      @restaurant = current_manager.restaurants.new(restaurant_params)
      if @restaurant.save 
        redirect_to backstage_root_path(current_manager.id), notice: '餐廳新增成功'
      else
        redirect_back(fallback_location: new_backstage_manager_restaurant_path, notice: '輸入錯誤錯誤')
      end
    end

    def edit
      render layout: 'backstage'
    end

    def update
      if @restaurant.update(restaurant_params)
        redirect_to backstage_restaurant_path(@restaurant), notice: '餐廳資訊更新成功'
      else
        render :show
      end
    end

    def show; end

    def destroy
      @restaurant.destroy
      redirect_to backstage_root_path(current_manager.id), notice: '餐廳已刪除'
    end

    private

    def restaurant_params
      params.require(:restaurant).permit(:title, :tel, :address, :branch, :period_of_reservation, :tag_list,
                                         :dining_time, :content, :interval_time, images: [], menus: [])
    end

    def find_restaurant
      @restaurant = current_manager.restaurants.find(params[:id])
    end
  end
end
