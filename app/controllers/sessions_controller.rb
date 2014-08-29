class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, alert: 'Logged in!'
    else
      redirect_to login_path, alert: 'Invalid credentials; please try again'
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path, alert: 'Logged out!'
  end
end
