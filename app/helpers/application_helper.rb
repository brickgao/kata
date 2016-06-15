module ApplicationHelper
  def authenticate_user!
    flash[:warning] = 'You need to login'
    redirect_to '/login' if session[:user_id] == nil
  end
end
