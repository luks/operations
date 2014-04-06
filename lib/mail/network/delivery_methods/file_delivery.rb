require 'mail/check_delivery_params'

module Mail
  
  # FileDelivery class delivers emails into multiple files based on the destination
  # address.  Each file is appended to if it already exists.
  # 
  # So if you have an email going to fred@test, bob@test, joe@anothertest, and you
  # set your location path to /path/to/mails then FileDelivery will create the directory
  # if it does not exist, and put one copy of the email in three files, called
  # by their message id
  # 
  # Make sure the path you specify with :location is writable by the Ruby process
  # running Mail.
  class FileDelivery
    include Mail::CheckDeliveryParams

    if RUBY_VERSION >= '1.9.1'
      require 'fileutils'
    else
      require 'ftools'
    end

    def initialize(values)
      self.settings = { :location => './mails' }.merge!(values)
    end
    
    attr_accessor :settings
    
    def deliver!(mail)
      check_delivery_params(mail)

      if ::File.respond_to?(:makedirs)
        ::File.makedirs settings[:location]
      else
        ::FileUtils.mkdir_p settings[:location]
      end

      mail.destinations.uniq.each do |to|
      	separator = "\n" 
        ::File.open(::File.join(settings[:location], File.basename(to.to_s)), 'a') do |f| 
        	f.write(separator)
        	f.write(separator)
        	f.write("DATE:")
          f.write(mail.date)
					f.write(separator)
          f.write('SUBJECTS:')
          f.write(mail.subject)
          f.write(separator)
          f.write('FROM:')
          f.write(mail.from)
          f.write(separator)
          f.write('TO:')
          f.write(mail.to)
          f.write(separator)
          f.write('BODY:')
          f.write(separator)
          f.write(mail.body)
        end
      end
    end
    
  end
end