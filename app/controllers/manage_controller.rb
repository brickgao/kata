class ManageController < ApplicationController
  before_filter :authenticate_admin!

  def index
    render 'index'
  end
end
