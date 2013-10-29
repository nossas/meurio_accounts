Given(/^I'm in "(.*?)"$/) do |arg1|
  visit new_user_session_path(redirect_url: "http://panela.meurio.org.br") if arg1 == "the login page comming from Panela de Pressão"
end

Given(/^I'm a registered user with email "(.*?)" and password "(.*?)"$/) do |arg1, arg2|
  @user = User.make! email: arg1, password: arg2
end

Given(/^I fill "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in 'user_email', with: arg2 if arg1 == "the login email"
  fill_in 'user_password', with: arg2 if arg1 == "the login password"
end

When(/^I submit "(.*?)"$/) do |arg1|
  page.find('form#new_user input[type="submit"]').click if arg1 == "the login form"
end

Then(/^I should be logged in$/) do
  save_and_open_page
  cookies["warden.user.user.key"][0][0].should be_== @user.id
end
