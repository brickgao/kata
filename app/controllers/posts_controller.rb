class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => :index

  def index
    @query_page = (params[:page] || '1').to_i
    conditions = {}
    conditions[:user] = User.find(params[:user_id]) if params[:user_id]
    conditions[:node] = Node.find(params[:node_id]) if params[:node_id]
    @pages_total = (Post.where(conditions).count / posts_limit.to_f).ceil
    @posts = Post.order(id: :desc).where(conditions).limit(posts_limit).offset((@query_page - 1) * posts_limit)
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
