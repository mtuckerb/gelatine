require 'spec_helper'
require "cancan/matchers"

describe "LegacySupport" do
		User.destroy_all
		Room.destroy_all
		CheckIn.destroy_all
		Profile.destroy_all
		before(:each) do
			@room = FactoryGirl.create(:room)
			@user = FactoryGirl.create(:user)
			@profile = FactoryGirl.create(:profile, user_id: @user.id)
			@checkin = FactoryGirl.create(:check_in, user: @user, room: @room, :check_in_time => DateTime.now)
		end

	it "outputs valid json" do
		vlduca = Api::V0::LegacySupport.build.to_json
		parsed_body = JSON.parse(vlduca)
	  	parsed_body[0]["user_id"].should == @user.id
	end

	it "limits to today's entries" do
		time = Chronic.parse("last month")
	  	user = FactoryGirl.create(:user)
		profile = FactoryGirl.create(:profile, user_id: user.id)
		checkin = FactoryGirl.create(:check_in, user_id: user.id, check_in_time: time)
		params = {:timespan => "2 hours"}
		vlduca = Api::V0::LegacySupport.build(params).to_json
		parsed_body = JSON.parse(vlduca)
	  	(parsed_body.count).should eq(1)
	end
end