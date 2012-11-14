module VerifyUsersHelper
	def verified?
		current_user.user_status == "normal"
	end
end