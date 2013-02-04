require 'spec_helper'

describe "rooms/new" do
  before(:each) do
    assign(:room, stub_model(Room,
      :name => "MyString",
      :capacity => 1,
      :notes => "MyString"
    ).as_new_record)
  end

  it "renders new room form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rooms_path, :method => "post" do
      assert_select "input#room_name", :name => "room[name]"
      assert_select "input#room_capacity", :name => "room[capacity]"
      assert_select "input#room_notes", :name => "room[notes]"
    end
  end
end
