require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:alice)
    session[:user_id] = @user.id
  end

  test "should render successfully" do
    get :search, query: "test"
    assert_response :success
  end
end
