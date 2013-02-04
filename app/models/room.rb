class Room < ActiveRecord::Base
  attr_accessible :capacity, :name, :notes, :opdaystart, :opdaystop, :ophoursstart, :ophoursstop
  #validates_presence_of :name, :capacity, :opdaystart, :opdaystop, :ophoursstart, :ophoursstop
end
