module PostsHelper

  def get_user
    @_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def parse_content(content)
    last, ranges = 0, []
    content.to_enum(:scan, /https?:\/\/[\S]+/i).map do |match|
        ranges << [false, last, $`.size]
        last = $`.size + match.length
        ranges << [true, $`.size, last]
    end
    ranges << [false, last, content.length]
  end
end
