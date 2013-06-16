

	User.create(name: 'admin',email: 'admin@gmail.com', password: 'heslo1234', password_confirmation: 'heslo1234',role:"admin")
	User.create(name: 'user1',email: 'user1@gmail.com', password: 'heslo1234', password_confirmation: 'heslo1234',role:"operator")
	User.create(name: 'user2',email:  'user2@gmail.com', password: 'heslo1234', password_confirmation: 'heslo1234',role:"operator")
	User.create(name: 'user3',email: 'user3@gmail.com', password: 'heslo1234', password_confirmation: 'heslo1234',role:"operator")
	User.create(name: 'user4',email: 'user4@gmail.com', password: 'heslo1234', password_confirmation: 'heslo1234',role:"operator")
	User.create(name: 'user5',email: 'user5@gmail.com', password: 'heslo1234', password_confirmation: 'heslo1234',role:"operator")
	User.create(name: 'user6',email: 'user6@gmail.com', password: 'heslo1234', password_confirmation: 'heslo1234',role:"operator")
	User.create(name: 'user7',email: 'user7@gmail.com', password:  'heslo1234', password_confirmation: 'heslo1234',role:"operator")
	    

  	Status.create(name: "approved",title: "Schváleno")
  	Status.create(name: "reserved",title: "Rezervováno")
  
  	Shift.create(name: "denní",shift: "day")
  	Shift.create(name: "noční",shift: "night")
	
	Datacenter.create([{name:"Sever"},{name:"Jih"}])   


