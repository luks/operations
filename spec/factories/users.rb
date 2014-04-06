FactoryGirl.define do

	factory :user do |user|
	    user.name "lukapiske"
	    user.email "lukapiske@gmail.com"
	    user.password "martina1984"
	    user.password_confirmation "martina1984"
	    user.role "admin"
	end
end	