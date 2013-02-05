require 'spec_helper'
 
describe Room do
  
  it "has a valid factory" do
    FactoryGirl.create(:room).should be_valid
  end
  
  it "is invalid without a name" do
    pending
  end
  
end