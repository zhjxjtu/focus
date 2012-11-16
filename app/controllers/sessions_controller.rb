class SessionsController < ApplicationController
	before_filter :unsigned_in_user, only: [:new]
	
	def new
	end
	
	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in(user, params[:session][:remember_me])
			redirect_to users_path
		else
			flash[:error] = 'Invalid email or password'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
