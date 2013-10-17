Feature: Wrap App

  In order to simplify distributing Apps
  As as user
  I want wrap my App in a DMG

  Scenario: Create DMG
    Given an App
    When I wrap the App
    Then the App should be wrapped in a DMG

    #Scenario: Include parent directory in DMG
    #Given an App in a sub-directory
    #When I wrap the App with the parent directory
    #Then the App should be wrapped with the parent directory
