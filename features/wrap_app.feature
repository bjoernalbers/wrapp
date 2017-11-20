Feature: Wrap App

  In order to simplify distributing Apps
  As as user
  I want wrap my App in a DMG

  @announce
  Scenario: Wrap App
    Given an App
    When I wrap the App
    Then the App should be wrapped

  Scenario: Wrap App including the parent directory
    Given an App in a directory
    When I wrap the App including the parent directory
    Then the App should be wrapped including the parent directory

  Scenario: Wrap App including the /Applications symlink
    Given an App
    When I wrap the App including /Applications symlink
    Then the app should be wrapped including the /Applications symlink

  Scenario: Display usage
    When I run `wrapp`
    Then I should see usage instructions
