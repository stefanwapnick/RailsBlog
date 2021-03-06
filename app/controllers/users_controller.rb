class UsersController < ApplicationController
  before_action :set_user, only: [:update, :show, :update, :edit, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You have successfully registered as #{@user.username}"
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render action: 'new'
    end

  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Information updated.'
      redirect_to articles_path
    else
      render action: 'edit'
    end

  end

  def destroy
    @user.destroy
    flash[:danger] = 'User and all articles created by user have been deleted'

  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find params[:id]
  end
  def require_same_user
    if !logged_in? || (current_user.id != @user.id && !current_user.admin?)
      flash[:danger] = 'Cannot access user page'
      redirect_to root_path
    end
  end

end