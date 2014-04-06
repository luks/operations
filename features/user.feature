Feature: User behaviour
  In order to have more roles
  I want user with role operator can edit own password only
  I want admin to handle users
  
  Scenario Outline: Show or hide change password link

    Given the following users records
      | email 	  					| password     | role 		| name 	  	| password_confirmation  |
      | operator@gmail.com  | operator1234 | operator | operator 	| operator1234           |
      | admin@gmail.com    	| admin1234    | admin  	| admin 	  | admin1234              | 
    Given I am logged in as "<login>" with password "<password>"
    When I visit profile update for "<login>"
    Then I should <action>
    
    Examples:
      | login              |   password   | action                 |
      | admin@gmail.com    | admin1234    | see "Seznam uživatelů" |
      | operator@gmail.com | operator1234 | see "You are not authorized to access this page." |
      | operator@gmail.com | admin1234    | not see "Seznam uživatelů" |
      




