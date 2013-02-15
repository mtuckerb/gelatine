require 'spec_helper'

describe "reservations/show" do
  before(:each) do
    @reservation = assign(:reservation, stub_model(Reservation,
    :room => stub_model(Room, :id => 2, :name => "Window Bay 7"),
    :user => stub_model(User, :id => 1, :name => "Tucker"),
    :start_time => "Feb 8th at 9am UTC+10",
    :stop_time => "Feb 8th at 10am UTC+10",
      :attendie_count => 3
    ))
  end
  let(:ability){ Ability.new(user) }
  let(:user){ nil }
  
  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tucker/)
    rendered.should match(/Window Bay 7/)
    rendered.should match(/3/)
  end
end
