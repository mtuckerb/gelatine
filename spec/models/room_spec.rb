require 'spec_helper'
 
describe Room do
  
  it "has a valid factory" do
    FactoryGirl.create(:room).should be_valid
  end
  
  it "is invalid without a name" do
    FactoryGirl.build(:room, name: nil).should_not be_valid
  end
  
  it "has a unique name" do
    room1 = FactoryGirl.create(:room)
    room2 = FactoryGirl.build(:room)
    room2.should_not be_valid
    room2.should have(1).error_on(:name)
  end
  
  
end