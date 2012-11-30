class AcceptInvitationsController < ApplicationController
  def new
	@user = User.new
	@invitation = Invitation.new(inviter: params[:inviter], invitee: params[:invitee])
  end

  def create
	@user = User.new(params[:user])
	@invitation = Invitation.new(params[:invitation])
  	if @user.save
  	  if Invitation.find_by_inviter_and_invitee(@invitation.inviter, @invitation.invitee).destroy
      	sign_in(@user, params[:page_params][:remember_me])
      	flash[:success] = "Welcome to the Focus App! Your contact information has been sent back to #{User.find_by_id(@invitation.inviter).name}"
        #UserEmails.verify(@user).deliver
        @inviter = User.find(@invitation.inviter)
        @invitee = User.find_by_email(@invitation.invitee)
        @contact = Contact.new(inviter: @inviter.id, invitee:@invitee.id)
        @contact.save
  		  redirect_to root_path
      else
      	flash[:success] = "The invitation does not exist"
  		  redirect_to root_path
  	  end
  	else
  		render 'new'
  	end
  end
end