class Backstage::ManagersController < ApplicationController
  before_action :authenticate_manager!

  layout 'backstage'

  def show
    @restaurants = current_manager.restaurants
  end
end
