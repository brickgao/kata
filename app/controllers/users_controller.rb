class UsersController < ApplicationController
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

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
