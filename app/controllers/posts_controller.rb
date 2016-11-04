class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => :index

  def index
    @query_page = (params[:page] || '1').to_i
    conditions = {}
    @query_user = conditions[:user] = User.find(params[:user_id]) if params[:user_id]
    @query_node = conditions[:node] = Node.find(params[:node_id]) if params[:node_id]
    @pages_total = (Post.where(conditions).count / posts_limit.to_f).ceil
    @posts = Post.order(id: :desc).where(conditions).limit(posts_limit).offset((@query_page - 1) * posts_limit)
    @nodes = Node.all
    @extra_messages = @query_node.extra_messages.split("\n") if (
        @query_node and @query_node.extra_messages and
        @query_node.extra_messages.length > 0
    )
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.save
      redirect_to @post
    else
      flash[:danger] = @post.errors
      redirect_to new_post_url
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post.enable_markdown
      renderer = Redcarpet::Render::HTML.new(render_options = {})
      @markdown = Redcarpet::Markdown.new(renderer, extensions = {:tables => true, :highlight => true})
    end
    @comment = Comment.new
    @extra_messages = @post.node.extra_messages.split("\n") if (
        @post.node.extra_messages and
        @post.node.extra_messages.length > 0
    )
    $redis.hincrby(:post_hit, params[:id], 1)
  end

  private
  
    def post_params
      _params = params.require(:post).permit(:title, :body, :node, :enable_markdown)
      _params[:node] = Node.find(Integer(_params[:node]))
      _params[:user] = User.find(session[:user_id])
      _params
    end

    def posts_limit
      10
    end
end
