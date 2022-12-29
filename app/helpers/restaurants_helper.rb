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
    attr_reader :date_list

    def initialize(date_list)
      @date_list = date_list
    end

    def end_day(period_of_day)
      @end_day = Date.yesterday + period_of_day.days
    end

    def reservation_range_date(start_date)
      return if start_date >= @end_day

      @date_list << (start_date + 1.days).strftime('%m月%d日')
      reservation_range_date(start_date + 1.days)
    end
  end
end
