Feature: login

  Scenario: when I fill the login form wrong
    Given I'm in "the login page"
    And I'm not a registered user
    And I fill "the login email" with "trashmail@meurio.org.br"
    And I fill "the login password" with "12345678"
    When I submit "the login form"
    Then I should be in "the login page"
    And I should see "the login form errors"

  @javascript
  Scenario: when I login with my token
    Given there is an user
    When I'm in "this user login with token page"
    Then I should be redirected to "the edit page of my profile"
