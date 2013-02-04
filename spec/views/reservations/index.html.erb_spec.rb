require 'spec_helper'

describe "reservations/index" do
  before(:each) do
    assign(:reservations, [
      stub_model(Reservation,
        :user_id => 1,
        :room_id => 2,
        :attendie_count => 3
      ),
      stub_model(Reservation,
        :user_id => 1,
        :room_id => 2,
        :attendie_count => 3
      )
    ])
  end

  it "renders a list of reservations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
