require 'spec_helper'

# StaticPages Controller
describe "StaticPages" do
  
  #Landing Page
  describe "Landing page" do
    
    it "Should have title 'Focus | Home'" do
      visit root_path
      page.should have_selector('title', :text => 'Focus | Home')
    end

    it "Should have log 'Focus(Beta)'" do
      visit root_path
      page.should have_selector('a', :id => 'logo' ,:text => 'Focus(Beta)')
    end

    it "Should have link 'What is Focus?'" do
      visit root_path
      page.should have_selector('a', :text => 'What is Focus?')
    end

    it "Should have Signin form" do
      visit root_path
      page.should have_selector('form', :action => '/sessions', :method => 'post')
    end
 	
 	it "Should have Signup form" do
      visit root_path
      page.should have_selector('form', :action => '/users', :method => 'post')
    end

  end
end