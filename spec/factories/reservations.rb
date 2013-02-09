require 'chronic'
FactoryGirl.define do

  factory :reservation do
    start_time (Chronic.parse("Next Monday at 2pm").to_datetime)
    stop_time  (Chronic.parse("Next Monday at 3pm").to_datetime)
    attendie_count 2
    association(:user) 
    association(:room)
  end
  
end
