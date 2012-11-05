class StaticPagesController < ApplicationController
  before_filter :signed_in_user, only: [:landing]
  def landing
  end

  private

  def signed_in_user
  	redirect_to current_user unless current_user.nil?
  end
end
