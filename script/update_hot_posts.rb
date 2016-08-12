require "json"

def update_hot_posts
  posts = Post.order(id: :desc).limit(50)
  now, result = Time.now, []
  posts.each do |post|
    post_hit = $redis.hget(:post_hit, post.id).to_i
    score = (post.comments.count * 5 + post_hit) / (((post.created_at - now) / 60).abs ** 1.5)
    result << [post.id, score]
  end
  result.sort_by! { |i| -i[1] }
  result.map! { |i| i[0] }
  $redis.set :hot_posts, result[0...5].to_json
end

if __FILE__ == $0
  update_hot_posts
end
