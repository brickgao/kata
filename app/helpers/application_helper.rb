module ApplicationHelper

  def authenticate_user!
    flash[:warning] = 'You need to login'
    redirect_to '/login' if session[:user_id] == nil
  end

  def authenticate_admin!
    redirect_to '/' unless session[:user_id] != nil && User.find(session[:user_id]).user_type == 1
  end
end
