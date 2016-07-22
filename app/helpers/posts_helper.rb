module PostsHelper

  def get_user
    @_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def parse_content(content)
    last, ranges = 0, []
    content.to_enum(:scan, /https?:\/\/[\S]+/i).map do |matched|
        ranges << [:normal, last, $`.size]
        last = $`.size + matched.length
        range = [nil, $`.size, last]
        if /.*(.jpg|.png|.gif)/.match(matched)
          range[0] = :image
        elsif /(https:\/\/)?gist.github.com*/.match(matched)
          range[0] = :gist
        else
          range[0] = :link
        end
        ranges << range
    end
    ranges << [:normal, last, content.length]
  end

  def get_hot_posts
    total_posts = Post.count
    hot_posts_id = JSON.load($redis.get "hot_posts") || (total_posts - 4..total_posts).to_a
    puts hot_posts_id.inspect
    hot_posts_id.map { |id| Post.find id }
  end
end
