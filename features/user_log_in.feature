
Feature: Log in as user

  In ordet to get access to main page of the site
  As not registered user
  I wont to be able to log in as newcomer
  As newcomer
  I wont to be able to register as user
  As registered user
  I wont to be able to log in as user
  
  Scenario: Newcomer log in successfully
    Given I am not logged in yet
    When I visit to home page 
    And I click "Log in" link   
    And I fill in "password" field with "neofit"   
    And I click "Log in" button
    Then I should see "Registered as newcomer"
    And I should see "Registration" link
    And I should see "Log out" link   
  
  Scenario: Newcomer registered successfully
    Given I am logged in as newcomer
    When I click "Registration" link  
    And I fill in "Login" field with "user1" 
    And I fill in "Name" field with "Super User1"
    And I fill in "Email" field with "user1@example.com"
    And I fill in "Password" field with "superuser1"
    And I fill in "Password confirmation" field with "superuser1"
    And I click "Create User" button
    Then I should see "You have new login and password now"
    And I should see "Log in"

  Scenario: User log in successfully
    Given I am not logged in yet
    When I visit to home page 
    And I click "Log in" link 
    And I fill in "login" field with "user"
    And I fill in "password" field with "superuser"   
    And I click "Log in" button
    Then I should see "Welcome, Super User"
   
  
 
   
