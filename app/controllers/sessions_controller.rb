class SessionsController < ActionController::Base
	def index
	end

	def new
	end

	def create
		user = User.find_by_email(params[:email])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/users/#{session[:user_id]}"
		else
			flash[:errors] = ["Invalid Combination"]
			redirect_to "/"
		end
	end

	def show
		# @user = User.find_by_email(params[:email])
	end

	def log
		session[:user_id] = nil
		redirect_to '/sessions/new'
	end

end
