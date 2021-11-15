class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user.username}! You have successfully signed up."
      redirect_to articles_path
    else

    end
  end

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

end