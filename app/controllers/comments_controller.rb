class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @comment = Comment.new post_params
    if !@comment.save
      flash[:danger] = 'Body ' + @comment.errors.messages[:body][0]
    end
    redirect_to @comment.post
  end

  private
    def post_params
      _params = params.require(:comment).permit(:body, :post)
      _params[:user] = User.find(session[:user_id])
      _params[:post] = Post.find(Integer(_params[:post]))
      _params
    end
end
