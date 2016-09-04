class SearchController < ApplicationController
  add_template_helper SearchHelper

  def search
    @words_search = params[:query]
    return redirect_to '/' if @words_search.nil?
    @posts = Post.search(
        :query => {
            :multi_match => {
                :query => @words_search,
                :fields => ["title", "body"]
            }
        },
        :highlight => { 
            :fields => {
                :title => {},
                :body => {}
            }
        }
    )
    @search_results = @posts.results
    @search_records = @posts.records.records
  end
end
