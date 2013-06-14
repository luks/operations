@focus
Feature: User reservate shift
  In order to have simple application
  I want user with role operator easely reservate shift
  
  Scenario Outline: User reservate day

    Given the following datacentrum
    	| name  |
      | sever |
      | jih   |

    Given the following users 
      | email               | password     | role     | name      | password_confirmation  |
      | operator@gmail.com  | operator1234 | operator | operator  | operator1234           |
      | admin@gmail.com     | admin1234    | admin    | admin     | admin1234              | 
    Given I am operations worker logged in as "<login>" with password "<password>"  
    When I visit datacentrum "<name>"
    Then I should <action>  

    Examples:
     | name  | login              | password        | action             |
     | sever | operator@gmail.com | operator1234    | reservate  "sever" |
     | sever | admin@gmail.com    | admin1234       | confirm  "sever" |
