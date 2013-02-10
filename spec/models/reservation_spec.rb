# coding: utf-8

require 'spec_helper'
require 'chronic'


describe Reservation do
  before(:each) do
    @reservation = FactoryGirl.create(:reservation)
  end

  it "is invlaid without a user id" do
    expect {
      @reservation = FactoryGirl.create(:reservation, user_id: nil) 
    }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: User can't be blank/)
  end


    it "reject end_time if it is before start_time" do
      stop = DateTime.now
      start = DateTime.now + 3600
      expect {
       FactoryGirl.create(:reservation, start_time: start, stop_time: stop, created_at: nil, updated_at: nil)
      }.to raise_error
    end

    it "rejects reservation if outside of operating hours" do
      start_time = "Feb 13th 2016 at 1800"
      stop_time = "Feb 13th 2016 at 2000"
      expect {
        FactoryGirl.create(:reservation, start_time: start_time, stop_time: stop_time, created_at: nil, updated_at: nil)
      }.to  raise_error
    end

  it "is not already booked" do
    res = FactoryGirl.create(:reservation)
    res2 = res.dup
    res2.user = User.new(:name => "Test User", :email => "test@test.comr")
    expect(res2.save).to be_false
  end


  it "creates a relationship with Room" do
    @reservation.room = FactoryGirl.create(:room, name: "Test Room")
    @reservation.save
    expect(@reservation.room.name).to eq "Test Room"
  end

  it "creates a relationship with User" do
    expect(@reservation.user).not_to be_nil
  end
  
  it "parses natural language date to TimeWithZone Object" do
      @reservation.start_time = "Monday at 9am"
      @reservation.stop_time = "Monday at 10am"
      @reservation.save
      expect(@reservation.start_time).to be_a_kind_of(ActiveSupport::TimeWithZone)
      expect(@reservation.stop_time).to be_a_kind_of(ActiveSupport::TimeWithZone)
  end
end
describe "GET /reservations" do

end
