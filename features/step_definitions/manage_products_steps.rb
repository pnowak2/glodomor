Given /^the following manage_products:$/ do |manage_products|
  ManageProducts.create!(manage_products.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) manage_products$/ do |pos|
  visit manage_products_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following manage_products:$/ do |manage_products|
  manage_products.rows.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.should have_selector("table > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") { |td|
        td.inner_text.should == cell
      }
    end
  end
end
