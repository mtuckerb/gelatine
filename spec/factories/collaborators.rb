# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collaborator, :class => 'Collaborators' do
    user_id 1
    project_id 1
    order 1
  end
end
