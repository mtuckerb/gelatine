# coding: utf-8

require 'spec_helper'
require 'chronic'


describe Reservation do
  before(:each) do
    @reservation = Reservation.new()
  end
  
  it "should be invlaid without a user id" do
    @reservation.should have(1).error_on(:user_id)
    @reservation.should_not be_valid
  end
  
  context "room not available that day" do
    pending "…need test"
  end
  describe "GET /reservations" do
    reservation = Reservation.new(:user_id => 1, :start_time => "1500", :stop_time => "1700", :attendie_count => 1)
    it "works!" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      #get reservations_path
      #response.status.should be(200)
    end

    
    it "should not create a relationship with Room " do
      expect(reservation.room).to eq nil
    end
    
    it "should create a relationship with Room" do
      reservation.room = Room.new(:name => "Test Room")
      expect(reservation.room.name).to eq "Test Room"
    end

  end
end
