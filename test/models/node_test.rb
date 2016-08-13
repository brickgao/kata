require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @node = Node.new(name: "Test Node",
                     summary: "Here is test node")
  end

  test "should be valid" do
    assert @node.valid?
  end

  test "name should be present" do
    @node.name = " " * 10
    assert_not @node.valid?
  end
end
