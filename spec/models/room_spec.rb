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
    room = FactoryGirl.create(:room, ophoursstart: "0900", ophoursstop: "1700" , operating_days: "Monday, Tuesday, Wednesday")
    reservation = FactoryGirl.build(:reservation, start_time: "Feb 8th 2016 at 9:00am", stop_time: "Feb 8th at 5pm")
    expect(reservation.room.is_available(reservation.start_time,reservation.stop_time)).to be_true
  end
  
  it "fails if room is not available" do
    room = FactoryGirl.create(:room, ophoursstart: "0900", ophoursstop: "1700" , operating_days: "Monday, Tuesday")
    expect(room.is_available("Feb 8th 2016 at 6am UTC+10", "Feb 8th 2016 at 7am UTC+10")).to be_false
  end
end