require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @node, @user = nodes(:testnode), users(:alice)
    @post = Post.new(title: "Wow, such a post", body: "much text",
                     node: @node, user: @user, enable_markdown: true)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = " " * 10
    assert_not @post.valid?
  end

  test "body should be presnet" do
    @post.body = " " * 10
    assert_not @post.valid?
  end

  test "node should be presnet" do
    @post.node = nil
    assert_not @post.valid?
  end

  test "title should not be too short" do
    @post.title = "a" * 5
    assert_not @post.valid?
  end

  test "body should not be too short" do
    @post.body = "a" * 5
    assert_not @post.valid?
  end
end
