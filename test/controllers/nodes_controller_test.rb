require 'json'
require 'test_helper'

class NodesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should return nodes" do
    get :index
    assert_response :success
    data = Node.all.map { |node| { :id => node.id, :name => node.name } }
    assert_equal @response.body, JSON.dump(data)
  end
end
