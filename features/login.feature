Feature: login

  @javascript
  Scenario: when I came from another application
    Given I'm in "the login page comming from Panela de Pressão"
    And I'm a registered user with email "trashmail@meurio.org.br" and password "12345678"
    And I fill "the login email" with "trashmail@meurio.org.br"
    And I fill "the login password" with "12345678"
    When I submit "the login form"
    Then I should be redirected to "Panela de Pressão"

  @javascript
  Scenario: when I don't came from another application
    Given I'm in "the login page"
    And I'm a registered user with email "trashmail@meurio.org.br" and password "12345678"
    And I fill "the login email" with "trashmail@meurio.org.br"
    And I fill "the login password" with "12345678"
    When I submit "the login form"
    Then I should be redirected to "the edit page of my profile"

  Scenario: when I fill the login form wrong
    Given I'm in "the login page"
    And I'm not a registered user
    And I fill "the login email" with "trashmail@meurio.org.br"
    And I fill "the login password" with "12345678"
    When I submit "the login form"
    Then I should be in "the login page"
    And I should see "the login form errors"
