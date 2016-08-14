class UsersController < ApplicationController
  include SessionsHelper

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

  def show_setting
    render 'setting'
  end

  def change_setting
     if !params.require(:setting)[:password].nil?
       if current_user.authenticate(change_password_params[:password])
         current_user.password, current_user.password_confirmation = [
            change_password_params[:new_password],
            change_password_params[:new_password_confirmation]
         ]
         if current_user.save
           redirect_to '/'
         else
           flash[:danger] = current_user.errors.messages
           render 'setting'
         end
       else
         flash[:danger] = 'Incorrect old password'
         render 'setting'
       end
     end
  end

  private
  
    def user_params
      user_params = params.require(:user).permit(:name, :email, :password,
                                                 :password_confirmation)
      user_params[:user_type] = 0
      user_params
    end

    def change_password_params
      params.require(:setting).permit(:password, :new_password,
                                      :new_password_confirmation)
    end
end
