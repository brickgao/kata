class SearchController < ApplicationController
  before_filter :authenticate_user!

  def search
    @words_search = params[:query]
    return redirect_to '/' if @words_search.nil?
    @current_page = (params[:page] || '1').to_i
    posts = Post.search(
        :from => (@current_page - 1) * posts_limit,
        :size => posts_limit,
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
    begin
      @matched_posts_count = posts.results.total
      @pages_total = (posts.results.total / posts_limit.to_f).ceil
      @search_results = posts.results
      @search_records = posts.records.records
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
      @matched_posts_count, @pages_total = 0, 0
      @search_results, @search_records = [], []
    end
  end

private
  def posts_limit
    10
  end
end
