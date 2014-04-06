class ApplicationController < ActionController::Base
  layout "trip_adviser"
  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
 
end
