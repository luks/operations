FactoryGirl.define do

	factory :user do |user|
	    user.name "lukapiske"
	    user.email "lukapiske@gmail.com"
	    user.password "martina1984"
	    user.password_confirmation "martina1984"
	    user.role "admin"
	end

	factory :datacenter do |dc|
		dc.name "NORTH"
	end

	factory :day_collection do |dc|
    	dc.user_id 1
      	dc.status_id 1
      	dc.shift_id 1
      	dc.day_id 1	 
      	dc.center_id 1
	end

	factory :day do |day|
		day.date "2013-06-07"
	end		
end
