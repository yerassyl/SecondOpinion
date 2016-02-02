Feature:
  In order to create client account
  As a manager
  I want to accept client callback request

  Scenario: Client callback acceptance
    Given I am reviewing client callback from potential user
    When I click on accept client and create account
    Then Client account should be registered
