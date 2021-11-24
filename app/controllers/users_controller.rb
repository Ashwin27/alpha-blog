class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update, :destroy]
  before_action :require_user, except: [:show, :create, :new, :index]
  before_action :require_same_user, only: [:edit, :destroy]

  def set_user
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user.username}! You have successfully signed up."
      redirect_to login_path
    else
      render 'new'
    end
  end

  def update
    
    if @user.update(user_params)
      flash[:notice] = "Your account was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    
  end

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

  def show
    
    @articles = @user.articles
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5).all
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all associated articles have been deleted"
    redirect_to root_path
  end

  private

  def require_same_user
    if not current_user.admin and current_user != @user
      flash[:alert] = "You can only edit or delete your own profile"
      redirect_to current_user
    end
  end

end