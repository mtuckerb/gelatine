require 'faker'

FactoryGirl.define do
  factory :reservation do
    start_time "800"
    stop_time "1500"
    attendie_count 2
    user
    #room
  end


end
