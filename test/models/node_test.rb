require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @node = Node.new(name: "Test Node",
                     summary: "Here is test node",
                     icon_url: "sample url")
  end

  test "should be valid" do
    assert @node.valid?
  end

  test "name should be present" do
    @node.name = " " * 10
    assert_not @node.valid?
  end

  test "summary should be present" do
    @node.summary = " " * 10
    assert_not @node.valid?
  end

  test "icon_url should be present" do
    @node.icon_url = " " * 10
    assert_not @node.valid?
  end

  test "name should not be too long" do
    @node.name = "a" * 31
    assert_not @node.valid?
  end

  test "summary should not be too long" do
    @node.name = "a" * 51
    assert_not @node.valid?
  end

  test "icon_url should not be too long" do
    @node.name = "a" * 501
    assert_not @node.valid?
  end
end
