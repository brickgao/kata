class SearchController < ApplicationController
  def search
    @words_search = params[:query]
    return redirect_to '/' if @words_search.nil?
    @posts = Post.search(
        :query => { :match => { :title => @words_search } },
        :highlight => { :fields => { :title => {} } }
    )
  end
end
