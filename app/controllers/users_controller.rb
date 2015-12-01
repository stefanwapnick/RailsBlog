class UsersController < ApplicationController

  before_action :set_user, only[:update, :show, :update, :edit]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You have successfully registered #{@user.username}"
      redirect_to article_path
    else
      render action: 'new'
    end

  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Information updated."
      redirect_to article_path
    else
      render action: 'edit'
    end

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

end