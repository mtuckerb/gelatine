FactoryGirl.define do

  factory :reservation do
    start_time  DateTime.now
    stop_time  DateTime.now + 1.hour
    attendie_count 2
    user
    room
  end
  
end
