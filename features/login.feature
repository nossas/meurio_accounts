Feature: login

  Scenario: when I fill the login form wrong
    Given I'm in "the login page"
    And I'm not a registered user
    And I fill "the login email" with "trashmail@meurio.org.br"
    And I fill "the login password" with "12345678"
    When I submit "the login form"
    Then I should be in "the login page"
    And I should see "the login form errors"
