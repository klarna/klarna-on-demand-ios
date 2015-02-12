Feature: Typical Flows
  As an SDK developer
  I want to have some typical flows
  so I know if changes I make break basic functionality

  # Keep in mind 'launching' the applications is a non-action as appium's driver
  # always does that for you

  Scenario: Register with invoice and buy
    When I launch the sample application and press 'Buy 1 ticket'
    And I complete the registration process
    Then I should see a QR code for the ticket I bought
