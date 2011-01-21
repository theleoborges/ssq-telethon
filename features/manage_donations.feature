Feature: Manage donations
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Make a donation
    When I enter details to make a donation and continue:
        | amount      | 1 |
    Then I should see the payment gateway