Given(/^I'm in "(.*?)"$/) do |arg1|
  visit new_user_session_path(redirect_url: "http://127.0.0.1/pdp") if arg1 == "the login page comming from Panela de Pressão"
  visit new_user_session_path if arg1 == "the login page"
end

Given(/^I'm a registered user with email "(.*?)" and password "(.*?)"$/) do |arg1, arg2|
  @user = User.make! email: arg1, password: arg2
end

Given(/^I'm not a registered user$/) do
end

Given(/^I fill "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in 'user_email', with: arg2 if arg1 == "the login email"
  fill_in 'user_password', with: arg2 if arg1 == "the login password"
end

When(/^I submit "(.*?)"$/) do |arg1|
  page.find('form#new_user input[type="submit"]').click if arg1 == "the login form"
end

Then(/^I should be redirected to "(.*?)"$/) do |arg1|
  current_path.should be == "/pdp" if arg1 == "Panela de Pressão"
end

Then(/^I should be in "(.*?)"$/) do |arg1|
  current_path.should be == new_user_session_path
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_css ".flash.alert", text: I18n.t("devise.failure.not_found_in_database")
end
