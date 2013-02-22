# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    about_me "MyString"
    mood "MyString"
    twitter "MyString"
    goodreads "MyString"
    public_email "MyString"
    website "MyString"
    toc_accept false
    send_via_email false
  end
end
