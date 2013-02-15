require 'spec_helper'

describe "reservations/new" do
  before(:each) do
    assign(:reservation, stub_model(Reservation,
      :room => stub_model(Room, :id => 2, :name => "Window Bay 7", :ophoursstart => "0900", :ophoursstop => "1700", :operating_days => 'Monday, Tuesday, Wednesday, Thursday, Friday'),
      :user => stub_model(User, :id => 1, :name => "Tucker"),
      :attendie_count => 1,
      :start_date => "Feb 11th at 9am",
      :stop_date => "Feb 11th at 10am"
    ).as_new_record)
  end
  let(:ability){ Ability.new(user) }
  let(:user){ nil }
  
  it "renders new reservation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reservations_path, :method => "post" do
      assert_select "select#reservation_room_id", :name => "reservation[room_id]"
      assert_select "input#reservation_attendie_count", :name => "reservation[attendie_count]"
    end
  end
end
