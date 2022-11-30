Feature: Cucumber Web Testing
  In order to make sure the app is working
  as a developer
  I want to see that Sinatra has taken the stage

  Scenario: View main stage
    Given I am on the home page
    Then I should see "Home#index"