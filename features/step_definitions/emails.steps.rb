Given(/^datacenter$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:datacenter, hash)
  end
end

Given(/^users$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:user, hash)
  end
end

Given(/^I am users logged in as "(.*?)" with password "(.*?)"$/) do |email, pass|
  visit new_user_session_path
  fill_in "user_email", :with => email
  fill_in "user_password", :with => pass
  click_button I18n.t("login.sign_in")
end

When(/^I visit datacenter "(.*?)"$/) do |name|
  datacenter = Datacenter.find_by_name(name)
	visit datacenter_path(datacenter)
end

When(/^I do emailing related action$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^"(.*?)" should got email_reservate$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^"(.*?)" should got email_cancel$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^"(.*?)" should got email_cancel_confirmed$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^"(.*?)" should got email_confirm_reservate$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

