Feature: Wrap App

  In order to simplify distributing Apps
  As as user
  I want wrap my App in a DMG

  Scenario: Create DMG
    Given an App
    When I run wrapp
    Then the App should be wrapped in a DMG

  #Scenario: Create DMG with different output directory
  #Scenario: Create DMG with differnt info plist
