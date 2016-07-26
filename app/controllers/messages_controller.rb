class MessagesController < ApplicationController

  before_filter :authenticate_user!

  def new
    to_id = params[:to_id]
    return redirect_to '/' unless to_id
    @to = User.find(to_id)
    return redirect_to '/' unless @to
  end

  def create
  end

  private
    def current_user
      User.find(session[:user_id])
    end

    def messages_limit
      10
    end
end
