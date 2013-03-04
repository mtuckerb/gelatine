require 'spec_helper'
require "cancan/matchers"

describe "LegacySupport" do
		User.destroy_all
		Profile.destroy_all
		CheckIn.destroy_all
		Room.destroy_all
		before(:each) do
			@room = FactoryGirl.create(:room)
			@user = FactoryGirl.create(:user)
			@profile = FactoryGirl.create(:profile, user_id: @user.id)
			@checkin = FactoryGirl.create(:check_in, user: @user, room: @room, check_in_time: Chronic.parse("1 hour ago"))
	  		@user2 = FactoryGirl.create(:user)
			@profile2 = FactoryGirl.create(:profile, user_id: @user2.id, skill_list: "bogus skill")
			@checkin2 = FactoryGirl.create(:check_in, user_id: @user2.id, room: @room, check_in_time: Chronic.parse("last month"))
		end

	it "outputs valid json" do
		vlduca = Api::V0::LegacySupport.view_list_distinct_user_checkins_all.to_json
		parsed_body = JSON.parse(vlduca)
	  	parsed_body[0]["user_id"].should == @user.id
	end

	it "limits to today's entries" do
		vlduca = Api::V0::LegacySupport.view_list_distinct_user_checkins_all({:timespan => "2 hours"}).to_json
		JSON.parse(vlduca).count.should eq(1)
	 
	end

	it "returns all checked_in skills" do
	  # skills = Api::V0::LegacySupport.view_list_distinctusercheckins_aggregated({:filter => "skills", :timespan => "2 hours"})
	  # skills.should eq(["thi", "that", "the other"])
	  pending "acts_as_taggble not surviving test. TODO"
	end

	it "creates a munual checkin" do
	  Api::V0::LegacySupport.checkin_submit_manual({:sublocation => "Window Bay 1", :rfid => "001002"})
	end
end