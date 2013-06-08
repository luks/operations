# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	User.create(name: 'lukapiske',email: 'lukapiske@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"admin")

	User.create(name: 'Martina',email: 'toto@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Katarina',email: 'kata@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Ivo',email: 'ivo@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Biserka',email: 'bisa@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Nedeljko',email: 'nede@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Katica',email: 'katica@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Ceca',email: 'ceca@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")

	    

    Status.create(name: "approved",title: "Schvaleno")
    Status.create(name: "reserved",title: "Rezervovano")
  
    Shift.create(name: "denni",shift: "day")
    Shift.create(name: "nocni",shift: "night")
	
	Datacenter.create([{name:"NORTH"},{name:"SOUTH"}])   

#    DayCollection.create(day_id:1,user_id:1,status_id:2,shift_id:1)
#    DayCollection.create(day_id:1,user_id:2,status_id:1,shift_id:1)
#    DayCollection.create(day_id:1,user_id:3,status_id:2,shift_id:2)
