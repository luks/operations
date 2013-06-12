Feature: Sign in
	In order to use application 
	User should sign in 
	with email and password data

	Scenario: Sign in application
	Given I am on Sign in
	And I fill in "Email" with "lukapiske@gmail.com"
    And I fill in wrong "Password" with "martina1984"
    When I press "Sign in"
    Then page should have alert message "Invalid email or password."


    Scenario: Succesfully sign in application
    	Given I exist as a user
    	And I am not logged in
    	When I sign in
    	Then I see successful sign in message



    Scenario: Operator can change own password only
    	Given I exist as a operator
    	And I could sign in
    	When I sign in  
    	Then I could change my password only

    
    Scenario: Reservation confirm
        Given: Administrator is logged in
        When click on confirm 
        Then relevant user have to be notified    	

	