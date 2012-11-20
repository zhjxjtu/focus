class ContactsController < ApplicationController
  def show
	@invitees = Contact.find_by_inviter(current_user.id)
	@inviters = Contact.find_by_invitee(current_user.id)
  end
end