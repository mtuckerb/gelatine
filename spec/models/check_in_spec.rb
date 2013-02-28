require 'spec_helper'
require 'chronic'

describe CheckIn do
 let(:checkin){ CheckIn.create(:check_in_time => Chronic.parse("two months ago") , :room_id => 1, :user_id => 1) }

 it "tells us how many months since checkin" do
 	checkin.months_since.should eq(2)
 end	

 it "tells us how many days since checkin" do
 	pending
 end
 
 it "tells us how many minutes since checkin" do
 	pending
 end

 it "tells us how many seconds since checkin" do
 	pending
 end

 it "retrieves the venue through the room_id" do
   pending
 end

 it "retrieves the latest checkins for each user" do
 	CheckIn.create(:check_in_time => Chronic.parse("two months ago") , :room_id => 1, :user_id => 1)
 	CheckIn.create(:check_in_time => Chronic.parse("two months ago") , :room_id => 1, :user_id => 2)
 	CheckIn.create(:check_in_time => Chronic.parse("two months ago") , :room_id => 1, :user_id => 3)
 	CheckIn.create(:check_in_time => Chronic.parse("two months ago") , :room_id => 1, :user_id => 4)
 	CheckIn.distinct_checkins.should have(4).CheckIns # including the let(:checkin) this would create a total of 5 CheckIns, 4 of them are unique
 end
end
