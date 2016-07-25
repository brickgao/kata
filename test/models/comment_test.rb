require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:alice)
    @post = posts(:testpost)
    @comment = Comment.new(user: @user, post: @post, body: "example comment")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user should be present" do
    @comment.user = nil
    assert_not @comment.valid?
  end

  test "post should be present" do
    @comment.post = nil
    assert_not @comment.valid?
  end

  test "comment should not be too short" do
    @comment.body = " " * 8
    assert_not @comment.valid?
  end

  test "comment should not be too long" do
    @comment.body = "a" * 201
    assert_not @comment.valid?
  end
end
