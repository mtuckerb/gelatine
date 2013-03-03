class Api::V0::LegacySupportController < ApplicationController

	#load_and_authorize_resource
	def view_list_distinct_user_checkins_all

		@checkins = Api::V0::LegacySupport.build(params).compact!

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @checkins }
	    end
			
	end

	def view_list_distinctusercheckins_aggregated
		@tags = Api::V0::LegacySupport.skills(params).compatc!
	end
end
