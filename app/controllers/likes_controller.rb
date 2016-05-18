class LikesController < ApplicationController
	def index
	end

	def create
		Like.create(user_id: session[:user_id], secret_id: params[:sekritz])
		redirect_to '/secrets'
	end

	def destroy
		like = Like.find_by(secret_id: params[:unsekritz]) # or params[:id] per answer sheet
		like.destroy
		redirect_to '/secrets'
	end

	private
	def like_params
		params.require(:like).permit(:user_id, :secret_id)
	end
end
