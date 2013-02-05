class Reservation < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  attr_accessible :attendie_count, :room_id, :start_time, :stop_time, :user_id
  validates_presence_of :user_id
  serialize :operating_days
end
