class Notifier < ActionMailer::Base
  	
  default from: "operations@latoto.cz"

	def day_confirmation(day_collection)
		
		@day_collection = day_collection
	  mail(:to => "#{day_collection.user.name} <#{day_collection.user.email}>",:subject => "Oznámení o potvrzení směny") 

  end

  def day_destroy(day_collection, current_user)
    
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


end
