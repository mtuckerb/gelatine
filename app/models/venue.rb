class Venue < ActiveRecord::Base
  has_many :rooms
  has_many :checkins, :through => :rooms
  attr_accessible :name, :open_days, :open_from, :open_to
end
