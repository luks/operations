@focus
Feature: Emailing trough application
	Operator should be emailed when admin confirm his shift
	Operator should be emailed when admin change his shift
	Operator should be emailed when admin delete his shift 
	Admin should be emailed when operator cancel confirmed shift

	Scenario Outline: Users emailing actions

    Given datacenter
    	| name  |
      | sever |
      | jih   |

    Given users 
      | email                | password     | role      | name       | password_confirmation  |
      | operator@gmail.com   | operator1234 | operator  | operator   | operator1234           |
      | operator1@gmail.com  | operator1234 | operator1 | operator1  | operator1234           |
      | operator2@gmail.com  | operator1234 | operator2 | operator2  | operator1234           |
      | admin@gmail.com      | admin1234    | admin     | admin      | admin1234              | 
    Given I am users logged in as "<login>" with password "<password>"  
    When I visit datacenter "<name>"
    And I do emailing related action 
    Then "who" should got <action>  

    Examples:
      | name  | login               | password        | action               			| who       |
      | sever | operator@gmail.com  | operator1234    | email_reservate  					| nobody    |
      | sever | admin@gmail.com     | admin1234       | email_reservate  					| operator  |  
      | sever | operator1@gmail.com | operator1234    | email_cancel      				|	nobody		|
      | sever | admin@gmail.com     | admin1234       | email_cancel      				|	operator	|
      | sever | operator2@gmail.com | operator1234    | email_cancel_confirmed    |	admin		  |
      | sever | admin@gmail.com     | admin1234       | email_confirm_reservate   |	operator	|	 		
      | sever | admin@gmail.com     | admin1234       | email_confirm_reservate   |	operator	|	


