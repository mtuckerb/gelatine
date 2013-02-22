# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :check_in do
    room_id 1
    check_in_time "2013-02-22 16:44:15"
    check_out_time "2013-02-22 16:44:15"
    third_party_id "MyString"
    user_id 1
  end
end