class MessagesController < ApplicationController

  before_filter :authenticate_user!

  def new
    to_id = params[:to_id]
    return redirect_to '/' unless to_id
    @to = User.find(to_id)
    return redirect_to '/' unless @to
  end

  def create
    @message = Message.new post_params
    if @message.save
      redirect_to '/'
    else
      flash[:danger] = @message.errors
      redirect_to "/messages/new?to_id=#{params.require(:message)[:to_id]}"
    end
  end

  private
    def current_user
      User.find(session[:user_id])
    end

    def post_params
      _params = params.require(:message).permit(:body)
      _params[:is_read], _params[:from] = false, current_user
      _params[:to] = User.find(params.require(:message)[:to_id])
      _params
    end

    def messages_limit
      10
    end
end
