module VerifyUsersHelper
	def verified?
	  current_user.user_status == "normal"
	end

  def verified_user
    unless verified?
      redirect_to verify_user_path
    end
  end

	def unverfied_user
    unless !verified?
    redirect_to root_path
    end
  end

  def set_user_status(user, status)
    user.update_attribute(:user_status, status)
  end
end