Feature: Make donation
  In order to take over the world
  We want to collect millions of dollars
  by creation a fake flood appeal for donations
  
  Scenario: Make a donation
    When I enter details to make a donation and continue:
        | amount      | 1 |
    Then I should see the payment gateway