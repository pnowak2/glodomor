Feature: Manage manage_products
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new manage_products
    Given I am on the new manage_products page
    When I fill in "Name" with "name 1"
    And I fill in "Description" with "description 1"
    And I fill in "Price" with "price 1"
    And I press "Create"
    Then I should see "name 1"
    And I should see "description 1"
    And I should see "price 1"

  Scenario: Delete manage_products
    Given the following manage_products:
      |name|description|price|
      |name 1|description 1|price 1|
      |name 2|description 2|price 2|
      |name 3|description 3|price 3|
      |name 4|description 4|price 4|
    When I delete the 3rd manage_products
    Then I should see the following manage_products:
      |name|description|price|
      |name 1|description 1|price 1|
      |name 2|description 2|price 2|
      |name 4|description 4|price 4|
