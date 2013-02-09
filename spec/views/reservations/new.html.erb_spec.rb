require 'spec_helper'

describe "reservations/new" do
  before(:each) do
    assign(:reservation, stub_model(Reservation,
      :user_id => 1,
      :room_id => 1,
      :attendie_count => 1
    ).as_new_record)
  end

  it "renders new reservation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reservations_path, :method => "post" do
      assert_select "select#reservation_room_id", :name => "reservation[room_id]"
      assert_select "input#reservation_attendie_count", :name => "reservation[attendie_count]"
    end
  end
end
