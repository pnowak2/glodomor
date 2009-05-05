Feature: Manage user_sessions
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Create a new user account
    Given no user "joetest"
    When I create a new user "joetest" with password "skymonkey"
    Then the user "joetest" can log in with password "skymonkey"

