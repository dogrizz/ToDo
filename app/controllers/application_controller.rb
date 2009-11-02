# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :sidebar
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  	def sidebar
		@urgent = Task.all(:conditions => {'complete' => false}, :order => "priority DESC, created_at ASC", :limit => 5)
		@latest = Task.all(:conditions => {'complete' => false}, :order => "created_at DESC", :limit => 5)
	end
end
