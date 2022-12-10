module RestaurantsHelper

  def run_time(start_time, end_time)
    return if start_time.to_i >= end_time.to_i

    @time_list << (start_time + 30.minutes).strftime('%R')
    run_time(start_time + 30.minutes, end_time)
  end

  def rest_run_time(start_time, end_time)
    return if start_time.to_i >= end_time.to_i

    @rest_time_list << (start_time + 30.minutes).strftime('%R')
    rest_run_time(start_time + 30.minutes, end_time)
  end

  def set_end_time(period)
    @end_time = Date.today + period.days
  end

  def date_sort(start_date)
    return if start_date >= @end_time
    
    @date_list << (start_date + 1.days)
    date_sort(start_date + 1.days)
  end

end
