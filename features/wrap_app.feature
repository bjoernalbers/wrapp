Feature: Wrap App

  In order to simplify distributing Apps
  As as user
  I want wrap my App in a DMG

  Scenario: Wrap App
    Given an App
    When I wrap the App
    Then the App should be wrapped

  Scenario: Display usage
    When I run `wrapp`
    Then I should see usage instructions
