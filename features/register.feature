Feature: register
  In order to colaborate with Meu Rio
  As a visitor
  I want to register

  @javascript
  Scenario: when I came from another application
    Given I'm in "the register page comming from Panela de Pressão"
    And I fill "the register first name" with "Meu"
    And I fill "the register last name" with "Rio"
    And I fill "the register email" with "trashmail@meurio.org.br"
    And I fill "the register password" with "12345678"
    When I submit "the register form"
    Then I should be redirected to "Panela de Pressão"

  @javascript
  Scenario: when I don't came from another application
    Given I'm in "the register page"
    And I fill "the register first name" with "Meu"
    And I fill "the register last name" with "Rio"
    And I fill "the register email" with "trashmail@meurio.org.br"
    And I fill "the register password" with "12345678"
    When I submit "the register form"
    Then an user should be created
    And I should be redirected to "the edit page of my profile"

  @javascript
  Scenario: when I fill the login form wrong
    Given I'm in "the register page"
    And I fill "the register first name" with ""
    And I fill "the register last name" with ""
    And I fill "the register email" with "trashmail"
    And I fill "the register password" with "short"
    When I submit "the register form"
    Then I should see "first name field error"
    Then I should see "last name field error"
    Then I should see "email field error"
    Then I should see "password field error"

  Scenario: when I'm already registered
    Given I'm in "the email validation page"
    And I'm a registered user with email "trashmail@meurio.org.br" and password "12345678"
    And I fill "the validation email" with "trashmail@meurio.org.br"
    When I submit "the validation email form"
    Then I should be in "the create password page"
    Given I fill "the new password" with "12345678"
    When I submit "the new password form"
    Then I should be in "the edit page of my profile"

  Scenario: when I'm a totally new user
    Given I'm in "the email validation page"
    And I fill "the validation email" with "trashmail@meurio.org.br"
    When I submit "the validation email form"
    Then I should be in "the register page"
