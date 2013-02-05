require 'faker'

FactoryGirl.define do
  factory :reservation do |t|
    t.user_id  Faker::Address.zip_code
    t.room_id 1..9
    t.start_time 0001..2400
    t.stop_time 0001..2400
    t.attendie_count 1..9
  end
end
