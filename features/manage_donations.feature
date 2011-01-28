Feature: Make donation
  In order to take over the world
  We want to collect millions of dollars
  by creation a fake flood appeal for donations

  @wip
  @javascript
  Scenario: Make a donation
    When I enter details to make a donation and continue:
        | amount      | 1 |
    And pay via the payment gateway
    Then I get a confirmation that my donation was made


