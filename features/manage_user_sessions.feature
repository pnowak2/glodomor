Feature: Manage user_sessions
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new user_session
    Given I am on the new user_session page
    When I fill in "Login" with "login 1"
    And I fill in "Password" with "password 1"
    And I press "Login"
    Then I should see "login 1"
    And I should see "password 1"
    
