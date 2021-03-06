class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			@current_user = user
			flash[:success] = "Welcome to MyDiary"
			redirect_to @user
		else
			render 'new'
		end
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :status, :age, :sex, :password, :password_confirmation)
		end
end
