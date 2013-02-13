class Reservation < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  attr_accessible :attendie_count, :room_id, :start_time, :stop_time, :user_id
  validates_presence_of :user_id, :start_time, :stop_time
  serialize :operating_days
  validate :room_in_use
  validate :end_time_is_after_start_time
  validate :booking_within_operating_hours
  validate :date_is_in_the_past
  
  def to_ics
    RiCal.Calendar  do |cal|
      cal.event do |event|
        event.dtstart = self.start_time.strftime("%Y%m%dT%H%M%S")
        event.dtend = self.stop_time.strftime("%Y%m%dT%H%M%S")
        event.summary = "Reservation at #{self.room.name}"
        event.description = "Reservation at #{self.room.name}"
        event.location = 'Here !'
      end
    end
  end
  
  def send_confirmation
    ReservationMailer.confirmation(self).deliver
  end
  
  private

  def room_in_use
    if self.id 
      errors.add(:base,"This room is in use. Please reschedule") if Reservation.find(:first, :conditions => ["start_time < ? and stop_time > ? and room_id = ? and id != ?", self.stop_time, self.start_time, self.room_id, self.id]) != nil
    else
      errors.add(:base,"This room is in use. Please reschedule") if Reservation.find(:first, :conditions => ["start_time < ? and stop_time > ? and room_id = ?", self.stop_time, self.start_time, self.room_id]) != nil
    end
  end

  def end_time_is_after_start_time
    errors.add(:base,"Your end time is before your start time") if self.stop_time <  self.start_time
  end
  
  def date_is_in_the_past
    errors.add(:base,"Your reservation seems to be in the past") if self.start_time.to_time < Time.now
  end
  def booking_within_operating_hours
    errors.add(:base,"Your reservation falls outside of booking hours") unless self.room.is_available(self.start_time, self.stop_time)
  end
end
