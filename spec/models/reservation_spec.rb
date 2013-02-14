# coding: utf-8

require 'spec_helper'
require 'chronic'
require 'ri_cal'


describe Reservation do
  before(:each) do
    @reservation = FactoryGirl.create(:reservation)
  end

  it "is invlaid without a user id" do
    expect {
      @reservation = FactoryGirl.create(:reservation, user_id: nil) 
    }.to raise_exception(ActiveRecord::RecordInvalid, / User can't be blank/)
  end


    it "reject end_time if it is before start_time" do
      stop = "Monday at 9am"
      start = "Monday at 10am"
      expect {
       FactoryGirl.create(:reservation, start_time: start, stop_time: stop, created_at: nil, updated_at: nil)
      }.to raise_exception(ActiveRecord::RecordInvalid, /Your end time is before your start time/)
    end

    it "rejects reservation if outside of operating hours" do
      start_time = "Feb 13th 2016 at 1800"
      stop_time = "Feb 13th 2016 at 2000"
      expect {
        FactoryGirl.create(:reservation, start_time: start_time, stop_time: stop_time, created_at: nil, updated_at: nil)
      }.to  raise_exception(ActiveRecord::RecordInvalid, /Your reservation falls outside of booking hours/)
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
  
  it "fails to validate if date is in the past" do
    start_time = "feb 5th 2013 at 09:30 UTC+10"
    stop_time = "feb 5th 2013 2013 at 13:00 UTC+10"
    expect {
      FactoryGirl.create(:reservation, start_time: start_time, stop_time: stop_time)
    }.to raise_exception(ActiveRecord::RecordInvalid, /Your reservation seems to be in the past/)
  end
  it "returns an ics format" do
    @reservation.to_ics.should be_a(RiCal::Component::Calendar)
  end
  
  it "sends an email confirmation" do
    @reservation.send_confirmation
    ActionMailer::Base.deliveries.last.to.should == [@reservation.user.email]
  end
end
describe "GET /reservations" do

end
