class PostsController < ApplicationController

  before_filter :authenticate_user!

  def index
    page = params[:page] || '1'
    page = page.to_i - 1
    @posts = Post.limit(posts_limit).offset(page * posts_limit)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  private
  
    def post_params
      _params = params.require(:post).permit(:title, :body, :node)
      _params[:node] = Node.find(Integer(_params[:node]))
      _params[:user] = User.find(session[:user_id])
      _params
    end

    def posts_limit
      10
    end
end
