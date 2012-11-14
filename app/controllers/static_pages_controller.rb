class StaticPagesController < ApplicationController
  before_filter :unsigned_in_user, only: [:landing]
  
  def landing
  	@user = User.new
  end

  private

  def unsigned_in_user
    redirect_to current_user unless current_user.nil?
  end
end
