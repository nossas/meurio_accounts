Given(/^I'm in "(.*?)"$/) do |arg1|
  visit to_url(arg1)
end

Given(/^I'm a registered user with email "(.*?)" and password "(.*?)"$/) do |arg1, arg2|
  @user = User.make! email: arg1, password: arg2
end

Given(/^I'm not a registered user$/) do
end

Given(/^I fill "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in to_element(arg1), with: arg2
end

When(/^I submit "(.*?)"$/) do |arg1|
  page.find(to_element(arg1)).click
end

Then(/^I should be redirected to "(.*?)"$/) do |arg1|
  current_path.should be == to_url(arg1)
end

Then(/^I should be in "(.*?)"$/) do |arg1|
  current_path.should be == to_url(arg1)
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_css to_element(arg1), to_text(arg1)
end