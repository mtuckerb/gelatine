module ReservationsHelper
  
  def format_time(start_time,stop_time)
    return start_time.strftime("%l:%M%P ") + " - " + stop_time.strftime("%l:%M%P")
  end
  def format_date(stop_date)
    return " "+ stop_date.strftime("%b #{stop_date.day.ordinalize} %Y")
  end
end
