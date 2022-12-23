# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @restaurants = if params[:search]
                     Restaurant.joins(:tags).where('title LIKE ?',
                                                   "%#{params[:search]}%").or(Restaurant.joins(:tags).where(
                                                                                'tags.name LIKE ?', "%#{params[:search]}%"
                                                                              )).distinct
                   elsif params[:query]
                     Restaurant.includes(:tags).where(tags: { name: params[:query].to_s })
                   else
                     Restaurant.all
                   end

    @tags = Tag.all.sample(20)
  end
end
