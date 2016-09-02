class SearchController < ApplicationController
  def search
    words_search = params[:query]
    return redirect_to '/' if words_search.nil?
    @posts = Post.search(words_search).records.records
  end
end
