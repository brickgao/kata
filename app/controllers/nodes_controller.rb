class NodesController < ApplicationController

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

  private
    def post_params
      _params = params.require(:node).permit(:title, :body)
    end
end
