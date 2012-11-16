class StaticPagesController < ApplicationController
  before_filter :unsigned_in_user, only: [:landing]
  
  def landing
  	@user = User.new
  end
  
end
