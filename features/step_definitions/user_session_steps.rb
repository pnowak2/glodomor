Given /^no user (.+)$/ do |login|
  lambda{ User.find(login) }.should raise_error(ActiveRecord::RecordNotFound)
end

When /^I create a new user "(.+)" with password "(.+)"$/ do |login, password|
  visit new_user_path
  fill_in "user_login", :with => login
  fill_in "user_email", :with => "#{login}@test.org"
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
  click_button "Register"
end

Then /^the user "(.+)" can log in with password "(.+)"$/ do |login, password|
  visit logout_path
  fill_in "user_session_login", :with => login
  fill_in "user_session_password", :with => password
  click_button "Login"
  response.should contain("Login successful!")
end

