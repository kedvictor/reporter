Feature: User should manage reports 
 
  In order to manage time activity reports
  As signed in user
  I wont to be able to see and add activities
 
  Scenario: user can see your own activities for today
    Given I am signed in as "Super User"
    When I visit to main page 
    Then I should see "Activities for Super User"
    And I should see activities for today
   
  Scenario: user can see your own activities for different date using calendar
    Given I am signed in as "Super User" 
    When I visit to main page 
    And I click "20" link
    Then I should see "Activities for Super User"
    And I should see activities for "20" day of current month and year 

  Scenario: user can see your own activities for different date using date selector
    Given I am signed in as "Super User" 
    When I visit to main page 
    And I select "2011" from "date_year"
    And I select "March" from "date_month"
    And I select "12" from "date_day"
    And I click "Go" button
    Then I should see "Activities for Super User"
    And I should see activities for "12 March 2011"

  Scenario: user can see consolidated reports per month
    Given I am signed in as "Super User" 
    When I visit to main page 
    And I click "Consolidated report" link
    Then I should see "Consolidated report"

  Scenario: user can add activity to report
    Given I am signed in as "Super User" 
    When I visit to main page   
    And I click "Add record" link   
    And I fill in "Time" field with "11:11"
    And I fill in "Description" field with "Unique description" 
    And I click "Create Record" button
    Then I should see "11:11"
    And I should see "Unique description"
