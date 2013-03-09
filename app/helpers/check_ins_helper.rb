module CheckInsHelper
	def check_in_check_out
		if current_user
			if current_user.check_ins.last.is_checked_in
				 link_to "Check Out", check_out_path
			else
				link_to "Check In", new_check_in_path
			end
		end
	end
end
