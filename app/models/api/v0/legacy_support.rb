class Api::V0::LegacySupport 

    def self.build_distinct_user_checkins_list_all(params = {})
        @checkins = []
        User.includes(:check_ins => :room).each do |user|
            next if user.check_ins == []
            push = true

            if params.has_key?("location")
                push = false unless user.check_ins.last.room.name == params["location"]
            end

            if params.has_key?("timespan")
                case params[:timespan]
                when "today"
                    push = false unless user.check_ins.last.check_in_time > Chronic.parse('today at 12:00am')
                when "week"
                    push = false unless user.check_ins.last.check_in_time >  Chronic.parse('last week')
                when "2 hours"
                    push = false unless user.check_ins.last.check_in_time > Chronic.parse('2 hours ago')
                end
            end

            if params.has_key?("limit")
                 push = false unless @checkins.count <= params[:limit].to_i+1
            end
            @checkins.push(user) unless push == false
        end
   
    end

    def self.build(params = {})
        build_distinct_user_checkins_list_all(params)
    
        @checkins.map do |user| 
            
            next if user.check_ins == nil
            next unless user.profile 
            {
                "user_id" => user.id,
                "firstname" => user.name,
                "lastname" => nil,
                "check_in_time" => user.check_ins.last.check_in_time,
    			"months_since_checkin" => user.check_ins.last.months_since,
    			"hours_since_checkin" => nil,
    			"minutes_since_checkin" => nil,
    			"mainlocation" => "The Edge",
    			"sublocation" => user.check_ins.last.room.name,
    			"categories" => user.profile.interests,
    			"skills" => user.profile.skills,
    			"help" => user.profile.needs,
    			"status" => user.profile.mood,
    			"email" => user.profile.public_email,
    			"twitter" => user.profile.twitter,
    			"goodreadsurl" => user.profile.goodreads,
    			"blog" => user.profile.website
            }
        end
       
    end

end