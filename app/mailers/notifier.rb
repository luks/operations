class Notifier < ActionMailer::Base
  	
  default from: "operation@application.com"

	def shift_confirmation(day_collection)
		
		subject = "Oznámení o potvrzení směny"
		@day_collection = day_collection
	  mail(:to => "#{day_collection.user.name} <#{day_collection.user.email}>",:subject => subject) 

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

  def admin_update_shift(day_collection, fake)
      
  		diff = fake.diference(day_collection)

  		if diff.has_key?("status_id") and diff['status_id'] == 1
  			self.shift_confirmation(day_collection)
  		else

  			@title = "Administrátor zmenil vaší"
				@day_collection = day_collection
				subject = "Administrátor zmenil vaší směnu"
				to =  "#{day_collection.user.name} <#{day_collection.user.email}>" 
				mail(:to => to,:subject => subject) 
			end

  end
  
  def admin_delete_shift(day_collection)

  	 	@title = "Administrátor zrušil vaší"
      @day_collection = day_collection
			subject = "Administrátor zrušil vaší směnu"
			to =  "#{day_collection.user.name} <#{day_collection.user.email}>" 
			mail(:to => to,:subject => subject) 

  end

  def admin_create_shift(day_collection)
	
  		@title = "Administrátor vytvořil vaší"
			subject = "Administrátor vytvořil směnu"
			@day_collection = day_collection
			to =  "#{day_collection.user.name} <#{day_collection.user.email}>" 
			mail(:to => to,:subject => subject) 
			
  end	
end
