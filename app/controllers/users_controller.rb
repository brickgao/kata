class UsersController < ApplicationController

  add_template_helper UsersHelper
  before_filter :authenticate_user!, :only => :show

  def new
    redirect_to '/signup' if request.fullpath != '/signup'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render plain: 'success'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
