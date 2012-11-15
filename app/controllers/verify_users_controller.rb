class VerifyUsersController < ApplicationController
  	before_filter :unverfied_user, only: [:show]

	def index
	  @user = User.find(params[:id])
      if @user.user_status != "new"
        flash[:success] = "You account has been verified"
        redirect_to controller: 'users', action: 'show', id: @user.id
      elsif @user.verify_code == params[:verify_code]
        if set_user_status(@user, "normal")
          flash[:success] = "Congratulations! You account is verified now."
          sign_in(@user,"yes")
          redirect_to controller: 'users', action: 'show', id: @user.id
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

	private

    def unverfied_user
      unless !verified?
      redirect_to root_path
      end
    end

    def set_user_status(user, status)
      user.update_attribute(:user_status, status)
    end
end
