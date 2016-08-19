require 'test_helper'

class ManageControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    user = users(:alice)
    session[:user_id] = user.id
  end

  test "should get successfully" do
    get :index
    assert_response :success
  end
end
