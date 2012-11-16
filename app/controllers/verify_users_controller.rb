class VerifyUsersController < ApplicationController
  before_filter :unverfied_user, only: [:show, :edit]

	def index
	  @user = User.find(params[:id])
      if @user.user_status != "new"
        flash[:success] = "You account has been verified"
        redirect_to users_path
      elsif @user.verify_code == params[:verify_code]
        if set_user_status(@user, "normal")
          flash[:success] = "Congratulations! You account is verified now."
          sign_in(@user,"yes")
          redirect_to users_path
        else
          flash[:notice] = "User verification failed"
          redirect_to root_path
        end
      else
        flash[:notice] = "The verification link is not correct or expired"
        redirect_to root_path
      end	
	end

	def edit
	  flash[:success] = "An email has been sent to #{current_user.email}"
    render 'show'
    Thread.new{UserEmails.verify(current_user).deliver}		
	end

	def show
	end

end
