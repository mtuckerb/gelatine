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

  context "is not available that day" do
    pending "…need test"
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
  
end
describe "GET /reservations" do

end
