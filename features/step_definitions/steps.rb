Given(/^I'm logged in$/) do
  password = '12345678'
  User.make! password: password, email: "trashmail@meurio.org.br"
  visit root_path
  fill_in 'user_email', with: current_user.email
  fill_in 'user_password', with: password
  click_button 'Entrar'
end

Given(/^I'm logged in as admin$/) do
  step "I'm logged in"
  User.find_by_email("trashmail@meurio.org.br").update_attribute :admin, true
end

Given(/^I'm in "(.*?)"$/) do |arg1|
  visit to_url(arg1)
end

Given(/^I'm a registered user with email "(.*?)" and password "(.*?)"$/) do |arg1, arg2|
  User.make! email: arg1, password: arg2
end

Given(/^I'm not a registered user$/) do
end

Given(/^I fill "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in to_element(arg1), with: arg2
end

Given(/^I choose "(.*?)"$/) do |arg1|
  choose to_element(arg1)
end

Given(/^I check "(.*?)"$/) do |arg1|
  check to_element(arg1)
end

Given(/^there is an user$/) do
  @user = User.make!
end

When(/^I submit "(.*?)"$/) do |arg1|
  page.find(to_element(arg1)).click
end

When(/^I press "(.*?)"$/) do |arg1|
  page.find(to_element(arg1)).click
end

When(/^I click "(.*?)"$/) do |arg1|
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

Then(/^I should not see "(.*?)"$/) do |arg1|
  page.should_not have_css to_element(arg1), text: to_text(arg1)
end

Then(/^an user should be created$/) do
  @user = User.first
  @user.should_not be_nil
end

Then(/^show me the page$/) do
  save_and_open_page
end

Then(/^I should receive "(.*?)" by email$/) do |arg1|
  ActionMailer::Base.deliveries.should_not be_empty
end
