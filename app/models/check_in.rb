class CheckIn < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  attr_accessible :check_in_time, :check_out_time, :room_id, :third_party_id, :user_id, :user
  validates_presence_of :check_in_time, :user_id, :room_id
  
end
