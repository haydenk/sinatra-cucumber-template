Given(/^I am on the DuckDuckGo homepage$/) do
  visit 'https://www.duckduckgo.com'
end

When(/^I search for "(.*?)"$/) do |search_query|
  within('#search_form_homepage') do
    fill_in('q', :name => 'q', :with => search_query)
  end
end

Then(/^I should see the search results$/) do
  with_scope('div#main') do
    page.should have_content('sinatra-cucumber')
    page.should have_content('cucumber-sinatra')
    page.should have_content('Github')
  end
end