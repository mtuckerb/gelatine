class Room < ActiveRecord::Base
  has_many :reservations
  has_many :users, :through => :reservations
  has_many :checkins
  attr_accessible :capacity, :name, :notes, :ophoursstart, :ophoursstop, :operating_days
  validates_presence_of :name, :capacity, :operating_days, :ophoursstart, :ophoursstop
  validates_uniqueness_of :name
  paginates_per 10
  
  public
  
  def is_available(start_time, stop_time)
    stop_time = stop_time.to_time.localtime() 
    start_time = start_time.to_time.localtime()
     ((start_time.strftime("%H%M").to_i >= self.ophoursstart.to_i) &&
         (stop_time.strftime("%H%M").to_i <= self.ophoursstop.to_i) &&
         (self.operating_days.include?(start_time.strftime("%a") )) &&
         (self.operating_days.include?(stop_time.strftime("%a")) ))? true : false
  end
  
end
