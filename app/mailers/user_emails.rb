class UserEmails < ActionMailer::Base
  default from: "Focus Project Team <focustest.2012@gmail.com>"
  
  def verify(user)
  	@user = user
  	mail to: @user.email, subject: "You Focus account verification link"
  end

  def invite(inviter, invitee)
  	@inviter = inviter
  	@invitee = invitee
  	mail to: invitee, from: "\"#{@inviter.name}\"", subject: "Hi #{@invitee}, may I have your contact information please?"
  end
end