class ApplicationController < ActionController::Base
  protect_from_forgery

	def index
		render :index
	end

	def session_update
		if !session[:create_time]
			session[:create_time] = lambda{Time.now}.call
		end
	end
end
