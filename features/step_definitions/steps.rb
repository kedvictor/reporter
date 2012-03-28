Given /^I am not logged in yet$/ do
  visit logout_path
end

When /^I visit to home page$/ do
  visit root_path
end

When /^I click "([^"]*)" link$/ do |link_name|
  click_link link_name
end

When /^I fill in "([^"]*)" field with "([^"]*)"$/ do |field, value|
  fill_in field, :with => value
end

When /^I click "([^"]*)" button$/ do |button_name|
  click_button button_name
end

Then /^I should see "([^"]*)"$/ do |text|
  body.should have_content text
end

Then /^I should see "([^"]*)" link$/ do |link_name|
  body.should have_link link_name
end

Given /^I am logged in as newcomer$/ do
  visit login_path
  fill_in "Password", :with => 'neofit'
  click_button "Log in"
end

Given /^I am signed in as "([^"]*)"$/ do |name|
  visit login_path
  fill_in "Login", :with => 'user'
  fill_in "Password", :with => 'superuser'
  click_button "Log in"
end

When /^I visit to main page$/ do
  visit records_path
end

Then /^I should see activities for today$/ do
  body.should have_content Date.today.strftime("%d %B %Y (%A)")
end

Then /^I should see activities for "([^"]*)" day of current month and year$/ do |day|
  date = Date.today.change(:day => day.to_i)  
  body.should have_content date.strftime("%d %B %Y (%A)")
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |value, name|
  select value, :from => name 
end

Then /^I should see activities for "([^"]*)"$/ do |date_text|
  body.should have_content date_text
end




