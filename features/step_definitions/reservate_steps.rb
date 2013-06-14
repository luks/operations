Given(/^the following datacentrum$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:datacenter, hash)
  end
end
Given(/^the following users$/) do |table|
  table.hashes.each do |hash|
    FactoryGirl.create(:user, hash)
  end
end

Given(/^I am operations worker logged in as "(.*?)" with password "(.*?)"$/) do |email, pass|
  visit new_user_session_path
  fill_in "user_email", :with => email
  fill_in "user_password", :with => pass
  click_button I18n.t("login.sign_in")
end

When(/^I visit datacentrum "(.*?)"$/) do |name|
	datacenter = Datacenter.find_by_name(name)
	visit datacenter_path(datacenter)
end

Then(/^I should reservate  "(.*?)"$/) do |name|
  first('a', :text => I18n.t("calendar.actions.reservate_day")).click
  first('a', :text => I18n.t("calendar.actions.reservate_day")).click
  first('a', :text => I18n.t("calendar.actions.reservate_day")).click
  first('a', :text => I18n.t("calendar.actions.reservate_day")).click

  day_collections = DayCollection.all 
  expect(day_collections.count).to equal(4)
  #find('a', :text => I18n.t("calendar.actions.delete_day"))
end

Then(/^I should confirm  "(.*?)"$/) do |name|
  first('a', :text => I18n.t("calendar.actions.confirm_day"))
end


