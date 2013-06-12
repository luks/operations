def create_admin_visitor
	@visitor ||= {:name => 'lukapiske', :email => 'lukapiske@gmail.com', 
		:password => 'martina1984',:password_confirmation => 'martina1984', :role => 'admin'} 
end

def create_operator_visitor
	@visitor ||= {:name => 'martina', :email => 'martina@gmail.com', 
		:password => 'martina1984',:password_confirmation => 'martina1984', :role => 'operator'} 
end 	

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def create_user
  create_admin_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end


Given(/^I am on Sign in$/) do
  visit new_user_session_path
end

Given(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in('user_email', :with => "lukapiske@gmail.com") 
end

Given(/^I fill in wrong "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in('user_password', :with => "martina1984")
end

When(/^I press "(.*?)"$/) do |arg1|
  click_button("Sign in")
end

Then(/^page should have alert message "(.*?)"$/) do |arg1|
    #visit new_user_session_path
    #fill_in('user_email', :with => "lukapiske@gmail.com")
  	#fill_in('user_password', :with => "martina1984")
  	#click_button("Sign in")		
   	page.has_css?("p.alert", :text => 'Invalid email or password.')
end


def sign_in

  visit new_user_session_path
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
  find_user
end

Given(/^I exist as a user$/) do
  create_admin_visitor
end

Given(/^I am not logged in$/) do
  visit datacenters_path
  page.should_not have_content "Signed in successfully."
end

When(/^I sign in$/) do
   
  create_user
  sign_in    
  
end

Then(/^I see successful sign in message$/) do
  page.should have_content "Signed in successfully."
end

Given(/^I exist as a operator$/) do
  #create_operator_visitor
end

Given(/^I could sign in$/) do
  #sign_in
  #page.should_not have_content "Signed in successfully."
end

Then(/^I could change my password only$/) do
  #visit edit_user_path(@user.id)
  #fill_in "user_password", :with => 'martina1984'
  #fill_in "user_password_confirmation", :with => 'martina1984'
  #click_button "Aktualizovat User"
  #page.should have_content "You need to sign in or sign up before continuing."
end

Given(/^administrator is logged in$/) do
  create_operator_visitor
end

When(/^click on confirm$/) do
  create_user
  sign_in   
  @datacenter = { :name => "SOUTH" }
  
  @day_collection = { :user_id => 1,:status_id => 1, :day_id => 1, :center_id => 1 }
  @day = { :date => Date.new(2013,06,10) }
  
  FactoryGirl.create(:datacenter, @datacenter)
  FactoryGirl.create(:day, @day)
  FactoryGirl.create(:day_collection, @day_collection)

  visit '/datacenters/1'
end

Then(/^relevant user have to be notified$/) do
   
end







