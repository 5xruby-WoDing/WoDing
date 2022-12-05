class ManagersController < ApplicationController
  def show
    @restaurants = current_manager.restaurants
  end
end
