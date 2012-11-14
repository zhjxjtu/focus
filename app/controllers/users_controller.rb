class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :show, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :verified_user, only: [:index, :show, :edit, :update]
  before_filter :unverfied_user, only: [:verify_page, :verify_update]

  def new
  	@user = User.new
  end
  
  def create
    @user = User.new(params[:user])
  	if @user.save
      sign_in(@user, params[:page_params][:remember_me])
      flash[:success] = "Welcome to the Focus App!"
  		redirect_to @user
      Thread.new{UserEmails.verify(@user).deliver}
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "profile updated"
      sign_in(@user,"yes")
      redirect_to @user
    else
      render 'edit'
    end
  end

  def verify_page
  end

  def verify_resend
    #flash.keep[:notice] = "An email has been sent to #{current_user.email}"
    redirect_to current_user
    Thread.new{UserEmails.verify(current_user).deliver}
  end

  def verify
    @user = User.find(params[:id])
    if @user.user_status != "new"
      flash[:success] = "You account has been verified"
      redirect_to @user
    elsif @user.verify_code == params[:verify_code]
      if set_user_status(@user, "normal")
        flash[:success] = "Congratulations! You account is verified now."
        sign_in(@user,"yes")
        redirect_to @user
      else
        flash[:notice] = "User verification failed"
        redirect_to verify_url
      end
    else
      flash[:notice] = "The verification link is not correct or expired"
      redirect_to root_path
    end
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end 

  def verified_user
    unless verified?
      redirect_to verify_url
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