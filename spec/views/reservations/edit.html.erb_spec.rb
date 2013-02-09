require 'spec_helper'

describe "reservations/edit" do
  before(:each) do
    @reservation = assign(:reservation, stub_model(Reservation,
      :user_id => 1,
      :room_id => 1,
      :attendie_count => 1
    ))
  end

  it "renders the edit reservation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reservations_path(@reservation), :method => "post" do
      assert_select "select#reservation_room_id", :name => "reservation[room_id]"
      assert_select "input#reservation_attendie_count", :name => "reservation[attendie_count]"
    end
  end
end
