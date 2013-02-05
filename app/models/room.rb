class Room < ActiveRecord::Base
  attr_accessible :capacity, :name, :notes, :ophoursstart, :ophoursstop, :operating_days
  validates_presence_of :name, :capacity, :operating_days, :ophoursstart, :ophoursstop
end
