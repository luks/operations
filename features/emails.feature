@email
Feature: As user and administrator I have to be notified when following action are made
  Admin create shift   - inolved user  is notified
  Admin confirm shift  - inolved user  is notified
  Admin destroy shift  - inolved user  is notified
  User destroy confirmed shift - admin is notified

	Scenario Outline: Users emailing actions

    Given datacenter
    	| name  |
      | sever |
  
    Given day
      | date  |
      | 2013-06-20   |
      | 2013-06-21   |
      | 2013-06-22   |
      | 2013-06-23   |

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
      | email                | password  | role      | name       | password_confirmation  |
      | user1@gmail.com      | heslo1234 | operator  | user1      | heslo1234              |
      | user2@gmail.com      | heslo1234 | operator  | user2      | heslo1234              |
      | user3@gmail.com      | heslo1234 | operator  | user3      | heslo1234              |
      | admin@gmail.com      | heslo1234 | admin     | admin      | heslo1234              | 
    Given I am users logged in as "<login>" with password "<password>"  
    When I visit datacenter "<name>"
    And current user so some emailing related action 
    Then should get <action>  

    Examples:
      | name  | login               | password        | action               			|
      | sever | user1@gmail.com     | heslo1234       | email_reservate  					|
      | sever | admin@gmail.com     | heslo1234       | email_reservate  					|   
      | sever | user1@gmail.com     | heslo1234       | email_cancel      				|
      | sever | admin@gmail.com     | heslo1234       | email_cancel      				|
      | sever | user2@gmail.com     | heslo1234       | email_cancel_confirmed    |
      | sever | admin@gmail.com     | heslo1234       | email_confirm_reservate   |
      | sever | admin@gmail.com     | heslo1234       | email_confirm_reservate   |	


