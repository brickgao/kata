class MessagesController < ApplicationController

  before_filter :authenticate_user!

  def new
    to_id = params[:to_id]
    return redirect_to '/' unless to_id
    @to = User.find_by_id(to_id)
    return redirect_to '/' unless @to
  end

  def create
    @message = Message.new message_params
    if @message.save
      redirect_to '/'
    else
      flash[:danger] = @message.errors
      redirect_to "/messages/new?to_id=#{params.require(:message)[:to_id]}"
    end
  end

  def index
    @query_page = (params[:page] || '1').to_i
    conditions = { to: current_user }
    unqiue_from = Message.uniq.pluck(:from_id)
    @pages_total = (unqiue_from.length / messages_limit).ceil
    @messages = []
    unqiue_from[(@query_page - 1) * messages_limit...@query_page * messages_limit].each do |from_id|
      latest_message_from = Message.where({ from: current_user }).first
      latest_message_to = Message.where({ to: current_user }).first
      if latest_message_from && latest_message_to
        @messages << (latest_message_from.created_at > latest_message_to.created_at ? latest_message_from : latest_message_to)
      else
        @messages << (latest_message_from || latest_message_to)
      end
    end
    render plain: @messages.inspect
  end

  private
    def current_user
      User.find(session[:user_id])
    end

    def message_params
      _params = params.require(:message).permit(:body)
      _params[:is_read], _params[:from] = false, current_user
      _params[:to] = User.find(params.require(:message)[:to_id])
      _params
    end

    def messages_limit
      10
    end
end
