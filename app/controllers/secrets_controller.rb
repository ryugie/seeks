class SecretsController < ApplicationController
    # before_action :require_login, only: [:index, :create, :destroy]


  def index
  	@secrets = Secret.all
  	# redirect_to "/users/#{params[:id]}"
    @likes = Like.find_by(user_id: session[:user_id])
  end

  def new
  end

  def show
  end

  def create
    Secret.create(content: secret_params['content'], user_id: session[:user_id])
    redirect_to "/users/#{session[:user_id]}"
  end

  def destroy
    secret = Secret.find(params[:id]).destroy
    # secret.destroy if secret.user == current_user #checks
    redirect_to "/users/#{session[:user_id]}"
  end

  private
  def secret_params
    params.require(:secret).permit(:content)
  end
end
