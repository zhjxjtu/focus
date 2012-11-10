# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Focus::Application.initialize!

# Mailer configuration 
Focus::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  	:address => "smtp.gmail.com",
  	:port => 587,
  	:domain => "gmail.com",
  	:authentication => "plain",
  	:user_name => "focustest.2012@gmail.com",
  	:password => "Fifafifa99@focus",
  	:enable_starttls_auto => true
  }
end