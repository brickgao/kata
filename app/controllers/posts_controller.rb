class PostsController < ApplicationController
  def index
  end

  def new
  end

  def create
    render plain: prarms[:posts].inspect
  end
end
