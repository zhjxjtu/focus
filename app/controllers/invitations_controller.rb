class InvitationsController < ApplicationController
  def show
  	@invitation = Invitation.new
    @invitations = Invitation.where("inviter = ?", current_user.id)
  end

  def create
  	invitee = params[:invitation][:invitee]
    @invitation = Invitation.new(inviter: current_user.id, invitee: invitee)
  	if Invitation.find_by_inviter_and_invitee(current_user.id, invitee) !=nil
  	  flash[:success] = "A reminding email has been sent to #{invitee}"
  	  redirect_to invitation_path(current_user)
      UserEmails.invite(current_user, invitee).deliver
  	elsif @invitation.save
      flash[:success] = "An email has been sent to #{invitee}"
  	  redirect_to invitation_path(current_user)
      UserEmails.invite(current_user, invitee).deliver
  	else
  	  flash[:notice] = "Invitation failed"
  	  redirect_to invitation_path
  	end
  end
end
