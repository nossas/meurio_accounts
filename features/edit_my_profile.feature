Feature: edit my profile
  In order to give more information about myself
  As an user
  I want to edit my profile

  Scenario: when I submit the form correctly
    Given I'm logged in
    And I'm in "the edit page of my profile"
    And I fill "the profession field" with "Programmer"
    And I fill "the website field" with "meurio.org.br"
    And I fill "the bio field" with "Hello World"
    And I fill "the Facebook field" with "nicolas.iensen"
    And I fill "the Twitter field" with "nicolasiensen"
    And I fill "the birthday field" with "06/03/1986"
    And I choose "male as gender"
    And I fill "the postal code field" with "22280-020"
    And I fill "the phone field" with "(21) 99999-9999"
    When I press "the edit profile form submition button"
    Then I should be in "my profile page"

  @javascript
  Scenario: when I submit the form with errors
    Given I'm logged in
    And I'm in "the edit page of my profile"
    And I fill "the email field" with ""
    And I fill "the secondary email field" with "trashmailmeurio.org.br"
    And I fill "the postal code field" with "1234"
    And I fill "the phone field" with "1234"
    And I fill "the website field" with "meurioorgbr"
    When I press "the edit profile form submition button"
    Then I should be in "the edit page of my profile"
    And I should see "the email error"
    And I should see "the secondary email error"
    And I should see "the postal code error"
    And I should see "the phone error"
    And I should see "the website error"

  Scenario: when I try to edit somebody elses profile
    Given there is an user
    When I'm in "this user edit page"
    Then I should be in "the login page"
    And I should see "you have no authorization to access this page"

  Scenario: when I try to edit somebody elses profile as an admin
