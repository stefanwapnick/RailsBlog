class SessionsController < ApplicationController

  def login
  end

  def new
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'You have successfully logged in'
      redirect_to users_path(user)
    else
      flash.now[:failure] = 'There was something wrong with your login information'
      render 'new'
    end

  end

  def logout
    session[:user_id] = nil
  end

end