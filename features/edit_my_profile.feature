Feature: edit my profile
  In order to give more information about myself
  As an user
  I want to edit my profile

  @javascript
  Scenario: when I submit the form correctly
    Given I'm logged in
    And I'm in "the edit page of my profile"
    And I fill "the profession field" with "Programmer"
    And I fill "the website field" with "meurio.org.br"
    And I fill "the bio field" with "Hello World"
    And I fill "the Facebook field" with "nicolas.iensen"
    And I fill "the Twitter field" with "nicolasiensen"
    And I fill "the birthday field" with "06/03/1986"
    And I choose "male" in "the gender field"
    And I fill "the postal code field" with "22280-020"
    And I fill "the cellphone field" with "(21) 99999-9999"
    When I submit the "edit profile form"
    Then I should be in "my profile page"

  Scenario: when I submit the form with errors
  Scenario: when I try to edit somebody elses profile
  Scenario: when I try to edit somebody elses profile as an admin
