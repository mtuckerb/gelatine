require 'faker'

def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end

FactoryGirl.define do
  time = time_rand
  factory :reservation do
    start_time = time
    stop_time = time+3600
    attendie_count 2
    user
    room
  end


end
