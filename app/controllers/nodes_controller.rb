class NodesController < ApplicationController

  before_filter :authenticate_admin!, :except => :index

  def index
    nodes = Node.all
    render json: nodes.map { |node| { :id => node.id, :name => node.name } }
  end

  def new
    @node = Node.new 
  end

  def create
    @node = Node.new post_params
    if @node.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def edit
    @node = Node.find(params.require(:id))
  end

  def update
    @node = Node.find(params.require(:id))
    if @node.update(post_params)
      redirect_to "/?node_id=#{@node.id}"
    else
      render 'edit'
    end
  end

  private
    def post_params
      _params = params.require(:node).permit(:name, :summary)
    end
end
