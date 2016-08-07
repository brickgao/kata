class MessagesController < ApplicationController

  before_filter :authenticate_user!

  def new
    to_id = params[:to_id].to_i
    return redirect_to '/' unless to_id && to_id != current_user.id
    @to = User.find_by_id(to_id)
    return redirect_to '/' unless @to
    return redirect_to "/chat?chat_with_id=#{@to.id}"
  end

  def create
    @message = Message.new message_params
    if current_user.id == message_params[:id]
      redirect_to "/"
    else
      if @message.save
        redirect_to "/chat?chat_with_id=#{@message.to.id}"
      else
        flash[:danger] = @message.errors
        redirect_to "/chat?chat_with_id=#{@message.to.id}"
      end
    end
  end

  def index
    @query_page = (params[:page] || '1').to_i
    condition_to, condition_from = { to: current_user }, { from: current_user }
    unqiue_from = Message.where(condition_to).uniq.pluck(:from_id) | Message.where(condition_from).uniq.pluck(:to_id)
    @pages_total = (unqiue_from.length / messages_limit).ceil
    @messages = []
    unqiue_from[(@query_page - 1) * messages_limit...@query_page * messages_limit].each do |id|
      user = User.find(id)
      latest_message_from = Message.order(id: :desc).where({ from: user, to: current_user }).first
      latest_message_to = Message.order(id: :desc).where({ to: user, from: current_user }).first
      has_unread = [
        Message.where({ from: user, to: current_user, is_read: 0}).first,
        Message.where({ from: current_user, to: user, is_read: 0}).first
      ].any?
      if latest_message_from && latest_message_to
        @messages << [(latest_message_from.created_at > latest_message_to.created_at ? latest_message_from : latest_message_to), has_unread]
      else
        @messages << [(latest_message_from || latest_message_to), has_unread]
      end
    end
    @messages.sort_by! { |message, has_unread| message.created_at }
  end

  def show_chat
    chat_with_id = params[:chat_with_id].to_i
    return redirect_to '/' unless chat_with_id && chat_with_id != current_user.id
    @chat_with_user = User.find_by_id(chat_with_id)
    return redirect_to '/' unless @chat_with_user
    t = Message.arel_table
    @messages = Message.order(id: :desc).where(
        (t[:from_id].eq(current_user.id).and(t[:to_id].eq(@chat_with_user.id))).or(
         t[:from_id].eq(@chat_with_user.id).and(t[:to_id].eq(current_user.id))
        )
    ).limit(20).to_a
    @messages.sort_by! { |message| message.created_at }
    if !@messages.empty? && @messages[-1].to.id == current_user.id
      @messages.each do |message|
        message.is_read = 1
        message.save
      end
    end
    render 'messages/show_chat'
  end

  def get_unread_messages_count
    render json: { :unread_messages_count => Message.where({ to: current_user, is_read: 0 }).count }
  end

  private
    def current_user
      User.find(session[:user_id])
    end

    def message_params
      _params = params.require(:message).permit(:body)
      _params[:is_read], _params[:from] = 0, current_user
      _params[:to] = User.find(params.require(:message)[:to_id])
      _params
    end

    def messages_limit
      10
    end
end
