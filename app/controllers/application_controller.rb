class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  
  # before_filter do |controller|
  #    unless controller.class == Devise::SessionsController
  #      controller.class.cancan_resource_class.new(controller).load_and_authorize_resource
  #      
  #    end
  # end
  
end
