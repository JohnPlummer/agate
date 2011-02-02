Feature: Authentication

  So that users can be associated with an account
  As the site owner
  I want users to login

  Scenario: User not signed in
    Given I am not signed in
    When I go to the home page
    Then I should be redirected to the sign in page
