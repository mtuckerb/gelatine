require 'spec_helper'
 
describe Room do
  
  it "has a valid factory" do
    FactoryGirl.create(:room).should be_valid
  end
  
  it "is invalid without a name" do
    FactoryGirl.build(:room, name: nil).should_not be_valid
  end
  
  it "has a unique name" do
    room1 = FactoryGirl.create(:room, name: "Funny")
    room2 = FactoryGirl.build(:room, name: "Funny")
    room2.should_not be_valid
    room2.should have(1).error_on(:name)
  end
  
  it "can check its own availability" do
    room = FactoryGirl.create(:room, ophoursstart: "0900", ophoursstop: "1700" , operating_days: "Monday, Tuesday")
    expect(room.is_available(Chronic.parse("Monday at 9:30am").to_datetime, Chronic.parse("Monday at 10:30am"))).to be_true
  end
  
  it "fails if room is not available" do
    room = FactoryGirl.create(:room, ophoursstart: "0900", ophoursstop: "1700" , operating_days: "Monday, Tuesday")
    expect(room.is_available(Chronic.parse("Monday at 8:30am").to_datetime, Chronic.parse("Monday at 10:30am"))).to be_false
  end
end