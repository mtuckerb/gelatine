class Api::V0::LegacySupportController < ApplicationController

	#load_and_authorize_resource
	def view_list_distinct_user_checkins_all

		@checkins = Api::V0::LegacySupport.view_list_distinct_user_checkins_all(params)
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @checkins }
	    end
			
	end

	def view_list_distinctusercheckins_aggregated
		if params[:filter] ==  "skills" || params[:filter] ==  "help" || params[:filter] == "categories"
			@tags = Api::V0::LegacySupport.view_list_distinctusercheckins_aggregated(params).flatten
		else
			raise "no filter given"
		end
		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @tags }
	  end
	end

	#Create new checkin via API
	
	def checkin_submit_manual
		if params[:rfid] && params[:sublocation] && params[:mainlocation]

			@checkin = CheckIn.new(params[:checkin])
		    @checkin.room = Room.find(params[:sublocation])
		    @checkin.user = User.find_by_rfid(params[:rfid])
		    @checkin.check_in_time = DateTime.now
		    respond_to do |format|
		      if @checkin.save
		        format.json { render json: @checkin, status: :created, location: @checkin }
		      else
		        format.json { render json: @checkin.errors, status: "***FAIL*** +++RFID card is not assigend to a user yet. Please visit a staff member at the counter...+++" }
		      end
		    end	
		end
	end
end
