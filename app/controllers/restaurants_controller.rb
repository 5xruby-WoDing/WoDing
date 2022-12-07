class RestaurantsController < ApplicationController
  def show
    @seats = @restaurant.seats
  end
end
