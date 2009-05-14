Feature: Manage user_sessions
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Create a new user account
    Given no user "joetest@foo.com"
    When I create a new user "joetest@foo.com" with password "skymonkey"
    Then the user "joetest@foo.com" can log in with password "skymonkey"

  Scenario: Cannot login without account
    Given no user "joetest@foo.com"
    Then the user "joetest@foo.com" cannot log in with password "skymonkey"
