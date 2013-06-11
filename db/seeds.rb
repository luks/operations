

	User.create(name: 'lukapiske',email: 'lukapiske@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"admin")
	User.create(name: 'Martina',email: 'toto@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Katarina',email: 'kata@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Ivo',email: 'ivo@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Biserka',email: 'bisa@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Nedeljko',email: 'nede@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Katica',email: 'katica@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")
	User.create(name: 'Ceca',email: 'ceca@gmail.com', password: 'martina1984', password_confirmation: 'martina1984',role:"operator")

	    

    Status.create(name: "approved",title: "Schváleno")
    Status.create(name: "reserved",title: "Rezervováno")
  
    Shift.create(name: "denní",shift: "day")
    Shift.create(name: "noční",shift: "night")
	
	Datacenter.create([{name:"Sever"},{name:"Jih"}])   


