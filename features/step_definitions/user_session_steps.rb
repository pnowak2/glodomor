Given /^no user (.+)$/ do |login|
  lambda{ User.find(login) }.should raise_error(ActiveRecord::RecordNotFound)
end

When /^I create a new user "(.+)" with password "(.+)"$/ do |email, password|
  visit new_user_path
  fill_in "user_email", :with => "#{email}"
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
  click_button "Register"
end

Then /^the user "(.*)" can log in with password "(.*)"$/ do |login, password|
  login_using_form("Login successful!", login, password)
end

Then /^the user "(.*)" cannot log in with password "(.*)"$/ do |login, password|
  login_using_form("Couldn't log you in!", login, password)
end


def login_using_form(expectation, email='', password='')
  visit logout_path
  visit login_path
  fill_in "user_session_email", :with => email
  fill_in "user_session_password", :with => password
  click_button "Login"
  response.should contain(expectation)
end
