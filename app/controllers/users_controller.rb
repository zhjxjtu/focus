class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :show, :edit, :update]
  #before_filter :verified_user, only: [:index, :show, :edit, :update]  //for verify_user
  before_filter :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
  	@user = User.new
  end
  
  def create
    @user = User.new(params[:user])
  	if @user.save
      sign_in(@user, params[:page_params][:remember_me])
      flash[:success] = "Welcome to the Focus App!"
  		redirect_to root_path
      #UserEmails.verify(@user).deliver  //for verify_user
  	else
  		flash[:error] = @user.errors.full_messages[0]
      redirect_to signup_path
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
  
end