Given(/^I am on the home page$/) do
  visit '/'
end

Then(/^I should see "(.*?)"$/) do |message|
  page.should have_content(message)
end
