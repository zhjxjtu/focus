class ApplicationController < ActionController::Base
  protect_from_forgery
  include UsersHelper
  include SessionsHelper
  include VerifyUsersHelper
end
