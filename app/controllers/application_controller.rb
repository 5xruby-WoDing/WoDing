# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private
  def find_off_days
    @off_days = @restaurant.off_days.map(&:off_day)
  end
end
