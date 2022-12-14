module RestaurantsHelper

  class TimeRange
    attr_reader :time_points
    def initialize(time_points)
      @time_points = time_points
    end

    def intreval_time(opening_time, closed_time)
      return if opening_time >= closed_time
    
      unless (opening_time + 30.minutes).between?('2000-01-01 14:00'.to_time, '2000-01-01 17:00'.to_time)
        @time_points << (opening_time + 30.minutes).strftime('%R')
      end
      intreval_time(opening_time + 30.minutes, closed_time)
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
      @date = date.gsub(/月/, '/' ).gsub(/日/, '').to_date
  end

  def catch_time(time)
    @time = time.to_time
  end

  # class SortDate
  #   attr_reader :info
  #   def initialize(info)
  #     @info = info
  #   end

  #   def sort_time(reservation_infos)
  #     reservation_infos.each do |info|
  #       if info.arrival_date >= Date.today
  #         @info << [info.arrival_time.strftime('%R'), info.arrival_date, info.seat_id]
  #       end
  #     end
  #     @info
  #   end
  # end

end

  
