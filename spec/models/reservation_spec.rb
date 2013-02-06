# coding: utf-8

require 'spec_helper'
require 'chronic'


describe Reservation do
  before(:each) do
    @reservation = FactoryGirl.create(:reservation)
  end

  it "is invlaid without a user id" do
    @reservation = Reservation.new()
    @reservation.should have(1).error_on(:user_id)
    @reservation.should_not be_valid
  end

  context "is not available that day" do
    pending "…need test"
  end

  it "is not already booked" do
    res = FactoryGirl.attributes_for(:reservation)
    res1 = Reservation.new(res)
    res1.save
    res2 = Reservation.new(res)
    expect(res2.save).to be_false
  end


  it "creates a relationship with Room" do
    @reservation.room = Room.new(:name => "Test Room")
    expect(@reservation.room.name).to eq "Test Room"
  end

  it "creates a relationship with User" do
    expect(@reservation.user).not_to be_nil
  end


end
describe "GET /reservations" do

end
