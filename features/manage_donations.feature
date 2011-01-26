Feature: Make donation
  In order to take over the world
  We want to collect millions of dollars
  by creation a fake flood appeal for donations

  @javascript
  Scenario: Make a donation
    When I enter details to make a donation and continue:
        | amount      | 1 |
    Then show me the page
    And I enter my credit card details
        | card_type   | Visa |
        | number      | 4005550000000001 |
        | month       | 05 |
        | year        | 13 |
    Then I get a confirmation that my donation was made


