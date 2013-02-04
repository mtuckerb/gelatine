require 'spec_helper'

describe Reservation do
  before(:each) do
    @reservation = Reservation.new
  end
  
  it "should be invlaid without a user id" do
    @reservation.should have(1).error_on(:user_id)
    @reservation.should_not be_valid
  end
end
