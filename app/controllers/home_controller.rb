# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @restaurants = if params[:search]
                     Restaurant.where('title LIKE ?', "%#{params[:search]}%")
                   else
                     Restaurant.all
                   end
    @restaurants = Restaurant.includes(:tags).where(tags: { name: params[:query].to_s }) if params[:query]
  end
end
