class HomeController < ApplicationController
  def index
    @restaurants = Restaurant.all

    
    @restaurants = Restaurant.includes(:tags).where(tags: {name: "#{params[:query]}"}) if params[:query]
  end
end
