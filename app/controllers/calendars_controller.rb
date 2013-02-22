class CalendarsController < ActionController::Base
  def index
    res = Reservation.all
    rooms = Room.all
    @room_names = []
     rooms.each do |r| 
      @room_names.push({:name => r.name, :id => r.id})
    end
    @reservations = []
    res.each do |reservation|
      @reservations.push(:title => "", :start => reservation.start_time, :stop => reservation.stop_time)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @room_names }
    end
  end
  
end