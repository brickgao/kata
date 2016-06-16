class PostsController < ApplicationController

  before_filter :authenticate_user!

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.save
      render plain: 'success'
    else
      render 'new'
    end
  end

  private
  
    def post_params
      _params = params.require(:post).permit(:title, :body, :node)
      _params[:node] = Node.find(Integer(_params[:node]))
      _params[:user] = User.find(session[:user_id])
      _params
    end
end
