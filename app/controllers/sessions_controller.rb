class SessionsController < ApplicationController
  include SessionsHelper

  def new
    redirect_to '/' if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to '/'
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destory
  end
end
