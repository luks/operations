class Notifier < ActionMailer::Base
  	
  default from: "operations@latoto.cz"

	def shift_confirmation(day_collection)
		
		@day_collection = day_collection
	  mail(:to => "#{day_collection.user.name} <#{day_collection.user.email}>",:subject => "Oznámení o potvrzení směny") 

  end

  def shift_destroy(day_collection, current_user)
    
			@day_collection = day_collection
			admin = User.admin
			if current_user.admin?
				@title = "Administrátor zrušil vaší"
				subject = "Administrátor zrušil vaší směnu"
				to =  "#{day_collection.user.name} <#{day_collection.user.email}>" 
				mail(:to => to,:subject => subject) 
			else
				@title = "Uživatel #{day_collection.user.name} zrušil"
				subject = "Oznámení o zrušení směny" 	
				to = "#{admin.name} <#{admin.email}>"

				
				if day_collection.status.id == 1 
					mail(:to => to,:subject => subject) 
				end	
			end

  end	

  def admin_update_shift(day_collection)

  		@title = "Administrátor zmenil vaší"
			subject = "Administrátor zmenil vaší směnu"
			to =  "#{day_collection.user.name} <#{day_collection.user.email}>" 
			mail(:to => to,:subject => subject) 

  end
  
  def admin_delete_shift(day_collection)

  	  @title = "Administrátor zrušil vaší"
			subject = "Administrátor zrušil vaší směnu"
			to =  "#{day_collection.user.name} <#{day_collection.user.email}>" 
			mail(:to => to,:subject => subject) 

  end

  def admin_create_shift(day_collection)

  		
  	  @title = "Administrátor vytvoril vaší"
			subject = "Administrátor vytvoril směnu"
			to =  "#{day_collection.user.name} <#{day_collection.user.email}>" 
			mail(:to => to,:subject => subject) 

  end	
end
