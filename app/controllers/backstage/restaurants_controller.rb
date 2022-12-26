# frozen_string_literal: true

module Backstage
  class RestaurantsController < Backstage::ManagersController
    before_action :find_restaurant, only: %i[show edit update destroy]

    def new
      @restaurant = current_manager.restaurants.new
    end

    def create
      @restaurant = current_manager.restaurants.new(params_restaurant)
      if @restaurant.save
        redirect_to backstage_root_path(current_manager.id), notice: '新增成功'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @restaurant.update(params_restaurant)
        redirect_to backstage_manager_path(current_manager.id), notice: '更新成功'
      else
        render :edit
      end
    end

    def show
      @seats = @restaurant.seats

      @opening_time = OpeningTime.new
      @reservations = @restaurant.reservations.order(arrival_time: :asc)
      @opening_times = @restaurant.opening_times
      @q = @reservations.ransack(params[:q])
      @reservations = @q.result
    end

    def destroy
      @restaurant.destroy
      redirect_to backstage_root_path(current_manager.id), notice: '已刪除'
    end

    def statistics
      restaurant = Restaurant.find(params[:restaurant_id])
      reservation = restaurant.reservations.where(arrival_date: params[:date])
      sum = reservation.size
      sum_of_people = reservation.reduce([]) { |arr, r| arr << (r.adult_quantity + r.child_quantity) }.sum
      render json: { sum:, sum_of_people: }
    end

    private

    def params_restaurant
      params.require(:restaurant).permit(:title, :tel, :address, :branch, :period_of_reservation, :tag_list,
                                         :dining_time, :content, images: [])
    end

    def find_restaurant
      @restaurant = current_manager.restaurants.find(params[:id])
    end
  end
end
