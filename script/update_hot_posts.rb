require "json"

def update_hot_posts
  posts = Post.order(id: :desc).limit(50)
  now, result = Time.now, []
  posts.each do |post|
    score = post.comments.count / (((post.created_at - now) / 60).abs ** 1.5)
    result << [post.id, score]
  end
  result.sort_by! { |i| -i[1] }
  result.map! { |i| i[0] }
  $redis.set "hot_posts", result[0...5].to_json
end

if __FILE__ == $0
  update_hot_posts
end
