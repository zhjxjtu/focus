class ContactsController < ApplicationController
  def show
	@invitees = Contact.all(conditions: "inviter = #{current_user.id}")
	@inviters = Contact.all(conditions: "invitee = #{current_user.id}")
	@contact = User.new
  end
end