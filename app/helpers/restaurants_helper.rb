# frozen_string_literal: true

module RestaurantsHelper
  class TimeRange
    def initialize(opening_time, interval_time)
      @opening_time = opening_time.order(opening_time: :asc)
      @interval_time = interval_time.minutes.to_i
    end

    def time_collection
      @time_points = @opening_time.reduce([]) { |arr, time| arr << (time.opening_time.to_i..time.closed_time.to_i) }
    end

    def interval_time
      @time_points.each_with_object([]) do |time, arr|
        time.step(@interval_time) { |t| arr << Time.at(t).strftime('%R') }
      end
    end
  end

  class DateRange
    def initialize(off_days, period_of_day)
      @off_days = off_days
      @end_day = Date.today + (period_of_day.days - 1)
    end

    def reservation_range_date
      (Date.today..@end_day).select{|date| @off_days.exclude?(date.strftime('%a'))}
    end
  end
end
