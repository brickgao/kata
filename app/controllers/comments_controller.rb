class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @comment = Comment.new post_params
    if !@comment.save
      flash[:danger] = 'Body ' + @comment.errors.messages[:body][0]
    end
    redirect_to @comment.post
  end

  def index
    @query_page = (params[:page] || '1').to_i
    conditions = {}
    conditions[:user] = User.find(params[:user_id]) if params[:user_id]
    @pages_total = (Comment.where(conditions).count / comments_limit.to_f).ceil
    @comments = Comment.where(conditions).limit(comments_limit).offset((@query_page - 1) * comments_limit)
  end

  private
    def post_params
      _params = params.require(:comment).permit(:body, :post)
      _params[:user] = User.find(session[:user_id])
      _params[:post] = Post.find(Integer(_params[:post]))
      _params
    end

    def comments_limit
      10
    end
end
