class UsersController < ApplicationController
  def new
  	@user = User.new
  end
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to @user
  	else
  		flash[:success] = "Welcome to the Focus App!"
  		render 'new'
  	end
  end
end