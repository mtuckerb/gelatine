class CheckIn < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  acts_as_api
  
  api_accessible :profiles_with_user do |t|
    t.add :check_in_time
    t.add :check_out_time
    t.add :third_party_id
  end

  attr_accessible :check_in_time, :check_out_time, :room_id, :third_party_id, :user_id, :user, :months_since
  validates_presence_of :check_in_time, :user_id, :room_id
  
  def months_since
  	 (Time.now.year * 12 + Time.now.month) - (self.check_in_time.year * 12 + self.check_in_time.month) 
  end

  def days_since

  end

  def hours_since

  end

  private

end
