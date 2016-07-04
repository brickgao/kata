class ApplicationController < ActionController::Base
  include ApplicationHelper
  add_template_helper UsersHelper
  add_template_helper PostsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
