class PostsController < ApplicationController
  def new
  end

  def create
    render plain: prarms[:posts].inspect
  end
end
