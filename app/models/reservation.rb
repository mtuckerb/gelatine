class Reservation < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  attr_accessible :attendie_count, :room_id, :start_time, :stop_time, :user_id
  validates_presence_of :user_id, :start_time, :stop_time
  serialize :operating_days
  validate :room_in_use
  validate :end_time_is_after_start_time

  private

  def room_in_use
    errors.add(:alert, "This room is in use. Please reschedule") if Reservation.find(:first, :conditions => ["start_time < ? and stop_time > ? and room_id = ? and id != ?", self.stop_time, self.start_time, self.room_id, self.id]) != nil
  end

  def end_time_is_after_start_time
    errors.add(:alert, "Your end time is before your start time") if self.stop_time <  self.start_time
  end

  end
