class HomeController < ApplicationController
  def index

    if params[:search]
      @restaurants = Restaurant.where("title LIKE ?", "%#{params[:search]}%")
    else
      @restaurants = Restaurant.all
    end
    @restaurants = Restaurant.includes(:tags).where(tags: {name: "#{params[:query]}"}) if params[:query]
    
  end
end
