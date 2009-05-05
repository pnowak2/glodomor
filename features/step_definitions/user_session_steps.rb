Given /^the following user_sessions:$/ do |user_sessions|
  UserSession.create!(user_sessions.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) user_session$/ do |pos|
  visit user_sessions_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following user_sessions:$/ do |user_sessions|
  user_sessions.rows.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.should have_selector("table > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") { |td|
        td.inner_text.should == cell
      }
    end
  end
end
