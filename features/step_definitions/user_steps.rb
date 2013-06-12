

Given(/^the following (.+) records$/) do |factory, table|
  # table is a Cucumber::Ast::Table

  table.hashes.each do |hash|
    FactoryGirl.create(:user, hash)
  end
end

Given(/^I am logged in as "(.*?)" with password "(.*?)"$/) do |email, password|
  visit new_user_session_path
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button I18n.t("login.sign_in")

end

When(/^I visit profile update for "(.*?)"$/) do |email|
	user = User.find_by_email!(email)
  visit users_path  
end

Then(/^I should see "(.*?)"$/) do |content|
  page.should have_content content
end

Then(/^I should not see "(.*?)"$/) do |content|
  page.should_not have_content content
end

