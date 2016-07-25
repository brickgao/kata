require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    from, to = users("alice"), users("bob")
    @message = Message.new(from: from, to: to,
                           body: "samplemessage", is_read: 0)
  end

  test "should be vaild" do
    assert @message.valid?
  end

  test "from should be present" do
    @message.from = nil
    assert_not @message.valid?
  end

  test "to should be present" do
    @message.to = nil
    assert_not @message.valid?
  end

  test "body should be present" do
    @message.body = nil
    assert_not @message.valid?
  end

  test "is_read should be present" do
    @message.is_read = nil
    assert_not @message.valid?
  end

  test "body should not be too short" do
    @message.body = " " * 3
    assert_not @message.valid?
  end

  test "body should not be too long" do
    @message.body = "a" * 300
    assert_not @message.valid?
  end
end
