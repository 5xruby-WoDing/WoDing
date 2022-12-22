# frozen_string_literal: true

module RestaurantsHelper
  class TimeRange
    def initialize(opening_time, intreval_time)
      @opening_time = opening_time
      @intreval_time = intreval_time.minutes.to_i
    end

    def time_collection
      @time_points = @opening_time.reduce([]){|arr, time| arr << (time.opening_time.to_i..time.closed_time.to_i)}
    end

    def intreval_time
      @time_points.reduce([]) do |arr, time|
        time.step(@intreval_time){|time| arr << Time.at(time).strftime('%R')}
        arr
      end
    end 
  end

  class DateRange
    attr_reader :date_list

    def initialize(date_list)
      @date_list = date_list
    end

    def set_end_day(period_of_day)
      @end_day = Date.yesterday + period_of_day.days
    end

    def reservation_range_date(start_date)
      return if start_date >= @end_day

      @date_list << (start_date + 1.days).strftime('%m月%d日')
      reservation_range_date(start_date + 1.days)
    end
  end

  def catch_date(date)
    @date = date.gsub(/\D/, '/' ).strip.to_date
  end

  def catch_time(time)
    @time = time.to_time
  end

  def catch_dining_time(dining_time)
    @dining_end_time = @time + dining_time.minutes
  end
end
