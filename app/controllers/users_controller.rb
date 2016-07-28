class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => :show

  def new
    redirect_to '/signup' if request.fullpath != '/signup'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/login'
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
