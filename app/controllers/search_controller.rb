class SearchController < ApplicationController
  add_template_helper SearchHelper
  before_filter :authenticate_user!

  def search
    @words_search = params[:query]
    return redirect_to '/' if @words_search.nil?
    @current_page = (params[:page] || '1').to_i
    @posts = Post.search(
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
    @pages_total = (@posts.results.total / posts_limit.to_f).ceil
    @search_results = @posts.results
    @search_records = @posts.records.records
  end

private
  def posts_limit
    10
  end
end
