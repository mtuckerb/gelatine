require 'chronic'
FactoryGirl.define do

  factory :reservation do
    start_time ("Feb 8th 2016 at 9am UTC+10")
    stop_time  ("Feb 8th 2016 at 10am UTC+10")
    attendie_count 2
    association(:user) 
    association(:room)
  end
  
end
