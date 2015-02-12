Feature: Typical Flows
  As an SDK developer
  I want to have some typical flows
  so I know if changes I make break basic functionality

  Scenario: Register with invoice and buy
    When I launch the sample application and press 'buy tickets'
    And I complete the registration process
    Then I should see a QR code for the ticket I bought
