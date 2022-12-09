module RestaurantsHelper

  def run_time(start_time, end_time)
    return if start_time.to_i >= (end_time).to_i

    @time_list << (start_time + 30.minutes).strftime("%R")
    run_time(start_time + 30.minutes, end_time)
  end

end
