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
        range[0] = /.*(.jpg|.png|.gif)/.match(matched) ? :image : :link
        ranges << range
    end
    ranges << [:normal, last, content.length]
  end
end
