@email
Feature: Emailing trough application
	Operator should be emailed when admin confirm his shift
	Operator should be emailed when admin change his shift
	Operator should be emailed when admin delete his shift 
	Admin should be emailed when operator cancel confirmed shift

	Scenario Outline: Users emailing actions

    Given datacenter
    	| name  |
      | sever |


    Given day
      | date  |
      | 2013-06-15   |
      | 2013-06-15   |
      | 2013-06-18   |
      | 2013-06-20   |

    Given shift
      | name  | shift |
      | denní | day   |
      | noční | night |  
      
     
    Given day_collections
      | day_id | user_id | shift_id | status_id | center_id  |
      |   3    |   1     |    1     |     1     |     1      |
      |   3    |   2     |    1     |     1     |     1      |
      |   3    |   3     |    1     |     2     |     1      |
      |   3    |   4     |    1     |     2     |     1      |
      |   4    |   1     |    1     |     1     |     1      |
      |   4    |   2     |    1     |     1     |     1      |
      |   4    |   3     |    1     |     2     |     1      |
      |   4    |   4     |    1     |     2     |     1      |


    Given users 
      | email                | password     | role      | name       | password_confirmation  |
      | operator@gmail.com   | operator1234 | operator  | operator   | operator1234           |
      | operator1@gmail.com  | operator1234 | operator  | operator1  | operator1234           |
      | operator2@gmail.com  | operator1234 | operator  | operator2  | operator1234           |
      | admin@gmail.com      | admin1234    | admin     | admin      | admin1234              | 
    Given I am users logged in as "<login>" with password "<password>"  
    When I visit datacenter "<name>"
    And current user so some emailing related action 
    Then "who" should get <action>  

    Examples:
      | name  | login               | password        | action               			| who       |
      | sever | operator@gmail.com  | operator1234    | email_reservate  					| nobody    |
      | sever | admin@gmail.com     | admin1234       | email_reservate  					| operator  |  
      | sever | operator1@gmail.com | operator1234    | email_cancel      				|	nobody		|
      | sever | admin@gmail.com     | admin1234       | email_cancel      				|	operator	|
      | sever | operator2@gmail.com | operator1234    | email_cancel_confirmed    |	admin		  |
      | sever | admin@gmail.com     | admin1234       | email_confirm_reservate   |	operator	|	 		
      | sever | admin@gmail.com     | admin1234       | email_confirm_reservate   |	operator	|	


