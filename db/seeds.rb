

	User.create(name: 'admin',email: 'admin@gmail.com', password: 'password1234', password_confirmation: 'password1234',role:"admin")
	User.create(name: 'toto',email: 'toto@gmail.com', password: 'password1234', password_confirmation: 'password1234',role:"operator")
	User.create(name: 'Kata',email: 'kata@gmail.com', password: 'password1234', password_confirmation: 'password1234',role:"operator")
	User.create(name: 'Ivo',email: 'ivo@gmail.com', password: 'password1234', password_confirmation: 'password1234',role:"operator")
	User.create(name: 'Bisa',email: 'bisa@gmail.com', password: 'password1234', password_confirmation: 'password1234',role:"operator")
	User.create(name: 'Nede',email: 'nede@gmail.com', password: 'password1234', password_confirmation: 'password1234',role:"operator")
	User.create(name: 'tica',email: 'tica@gmail.com', password: 'password1234', password_confirmation: 'password1234',role:"operator")
	User.create(name: 'Ceca',email: 'ceca@gmail.com', password: 'password1234', password_confirmation: 'password1234',role:"operator")

	    

  Status.create(name: "approved",title: "Schváleno")
  Status.create(name: "reserved",title: "Rezervováno")
  
  Shift.create(name: "denní",shift: "day")
  Shift.create(name: "noční",shift: "night")
	
	Datacenter.create([{name:"Sever"},{name:"Jih"}])   


