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
    And I should be redirected to "my profile page"

  Scenario: when I'm already registered
  Scenario: when I fill the login form wrong