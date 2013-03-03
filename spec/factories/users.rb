# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    sequence :email do |n|
      email = "person#{n}@#{Faker::Internet.domain_name}"
    end
    password "This15apassword"
    password_confirmation "This15apassword"
    confirmed_at Time.now
    role 'user'
  end
  
  factory :admin, :class => User do
    name Faker::Name.name
    sequence :email do |n|
      email = "person#{n}@#{Faker::Internet.domain_name}"
    end
    password "This15apassword"
    password_confirmation "This15apassword"
    confirmed_at Time.now
    role "admin"
  end
  
  factory :user_with_reservations do
    ignore do
      reservation_count 5
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:reservation, evaluator.reservations_count, user: user)
    end
  end


end
