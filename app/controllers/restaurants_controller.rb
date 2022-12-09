class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:show]
  def show
  end
  
  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
