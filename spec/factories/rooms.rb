require 'faker'

FactoryGirl.define do
  factory :room do |f|
    f.name  Faker::Name.name 
    f.ophoursstart "0900"
    f.ophoursstop "1700"
    f.operating_days 'Mon Tue Fri'
    f.capacity '2'
    f.notes Faker::Lorem.sentence
  end
end
