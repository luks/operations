require 'date'

Given(/^datacenter$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:datacenter, hash)
  end
end

Given(/^day$/) do |table|
   table.hashes.each do |hash|
    hash[:date] = Date.today
    FactoryGirl.create(:day, hash)
  end
end

Given(/^shift$/) do |table|
   table.hashes.each do |hash|
    FactoryGirl.create(:shift, hash)
  end
end

Given(/^users$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:user, hash)
  end
end

Given(/^day_collections$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:day_collection, hash)
  end
end


Given(/^I am users logged in as "(.*?)" with password "(.*?)"$/) do |email, pass|
  visit new_user_session_path
  fill_in "user_email", :with => email
  fill_in "user_password", :with => pass
  click_button I18n.t("login.sign_in")
  @current_user = User.find_by_email(email)
end

When(/^I visit datacenter "(.*?)"$/) do |name|
  @datacenter = Datacenter.find_by_name(name)
  visit datacenter_path(@datacenter)
end


When(/^current user so some emailing related action$/) do
  if@current_user.role == 'operator'
    first('a', :text => I18n.t("calendar.actions.reservate_day")).click 
    ActionMailer::Base.deliveries.size.should eq 0
  end 
  if @current_user.role == 'admin'
    first('a', :text => I18n.t("calendar.actions.confirm_day")).click  
    @email = ActionMailer::Base.deliveries.last
    @email.to.should include 'operator@gmail.com'
    #@email.subject.should include(arg1)
  end  

end

Then(/^"(.*?)" should get email_reservate$/) do |arg1|
  if@current_user.role == 'operator'
    ActionMailer::Base.deliveries.size.should eq 0
  end 
end

Then(/^"(.*?)" should get email_cancel$/) do |arg1|
   #@email = ActionMailer::Base.deliveries
  #puts @email
end

Then(/^"(.*?)" should get email_cancel_confirmed$/) do |arg1|
    #@email = ActionMailer::Base.deliveries
  #puts @email
end

Then(/^"(.*?)" should get email_confirm_reservate$/) do |arg1|
    #@email = ActionMailer::Base.deliveries
  #puts @email
end



