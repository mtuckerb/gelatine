require 'spec_helper'

describe "reservations/index" do
  before(:each) do
    assign(:reservations, [
      stub_model(Reservation,
        :room => stub_model(Room, :id => 2, :name => "Window Bay 7"),
        :user => stub_model(User, :id => 1, :name => "Tucker"),
        :start_time => "Feb 8th at 9am UTC+10",
        :stop_time => "Feb 8th at 10am UTC+10",
        :attendie_count => 3
      ),
      stub_model(Reservation,
        :room  => stub_model(Room, :id => 2, :name => "Window Bay 7"),
        :user => stub_model(User, :id => 1, :name => "Tucker"),
        :start_time => "Feb 8th at 9am UTC+10",
        :stop_time => "Feb 8th at 10am UTC+10",
        :attendie_count => 3
      )
    ])
  end

  it "renders a list of reservations" do
    # render
    #    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #    assert_select "tr>td", :text => "Tucker", :count => 2
    #    assert_select "tr>td", :text => "Window Bay 7", :count => 2
    #    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
