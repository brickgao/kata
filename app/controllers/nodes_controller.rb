class NodesController < ApplicationController

  def index
    nodes = Node.all
    render json: nodes.map { |node| { :id => node.id, :name => node.name } }
  end
end
