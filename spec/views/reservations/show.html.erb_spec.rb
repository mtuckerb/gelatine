require 'spec_helper'

describe "reservations/show" do
  before(:each) do
    @reservation = assign(:reservation, stub_model(Reservation,
    :room => stub_model(Room, :id => 2, :name => "Window Bay 7"),
    :user => stub_model(User, :id => 1, :name => "Tucker"),
      :attendie_count => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Tucker/)
    rendered.should match(/Window Bay 7/)
    rendered.should match(/3/)
  end
end
