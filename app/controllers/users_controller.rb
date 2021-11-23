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
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5).all
  end

end