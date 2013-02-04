require 'spec_helper'

describe "reservations/show" do
  before(:each) do
    @reservation = assign(:reservation, stub_model(Reservation,
      :user_id => 1,
      :room_id => 2,
      :attendie_count => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
