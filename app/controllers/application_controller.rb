# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private
  def find_off_days
    @off_days = OffDay.includes(:restaurant).where(restaurant_id: @restaurant).references(:off_day).map do |date|
      date.off_day
    end
  end
end
