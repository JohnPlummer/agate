Feature: Authentication

  So that users can be associated with an account
  As the site owner
  I want users to login

  Scenario: User not signed in
    Given I am not signed in
    When I go to the home page
    Then I should see "Sign up"

  Scenario: Register new user
    Given I am on the sign up page
    And I fill in the following within "form#user_new":
      | Username              | Fred         |
      | Email                 | fred@foo.bar |
      | Password              | password     |
      | Password confirmation | password     |
    When I press "Sign up"
    Then a new user should get created with the following details:
      | username | email        |
      | Fred     | fred@foo.bar |
    And I should receive an email with the following details:
      | subject                   | body                                                |
      | Confirmation instructions | You can confirm your account through the link below |
    And I should be on the home page
    And I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed."

  Scenario: Sign in user
    Given I am not signed in
    And I am a registered user
    And I am on the home page
    Then show me the page
    And I fill in the following:
      | user[username] | Fred     |
      | user[password] | password |
    When I press "Sign in"
    Then I should be on the home page
    And I should see "fred"
    And I should see "Signed in successfully."

  Scenario: User forgets password
    Given I am a registered user
    And I am on the reset password page
    And I fill in the following within "form#user_new":
      | Username | Fred |
    When I press "Send me reset password instructions"
    Then I should receive an email with the following details:
      | subject                     | body                                                 |
      | Reset password instructions | Someone has requested a link to change your password |
    And I should be on the sign in page
    And I should see "You will receive an email with instructions about how to reset your password in a few minutes."