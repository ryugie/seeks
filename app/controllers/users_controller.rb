class UsersController < ActionController::Base
	# before_action :require_login, except: [:new, :create]
	# before_action :require_correct_user, only: [:show, :edit, :update, :destroy]


	def index
		if flash[:errors].nil?
			flash[:errors] = ['']
		end

		@users = User.all
	end

# OR put something like this in the VIEW:

# <% if flash[:errors] %>
#   <% flash[:errors].each do |e| %>
#     <p><%= e %></p>
#   <% end %>
# <% end %>


	def new
	end

	def show
		@user = User.find(params[:id])
		@secrets = @user.secrets
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to "/users/#{@user.id}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to :back
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		@user.assign_attributes(user_params)

		if @user.save
			flash[:success] = ["User successfully updated"]
			redirect_to "/users/#{@user.id}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to "/users/#{@user.id}/edit"
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		session[:id] = nil
		redirect_to	'/users/new'
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
