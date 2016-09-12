require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:alice)
    session[:user_id] = @user.id
    Post.__elasticsearch__.index_name = 'posts_test'
    Post.__elasticsearch__.create_index!
    Post.__elasticsearch__.import
    Post.__elasticsearch__.refresh_index!
  end

  test "should render successfully" do
    get :search, query: "test"
    assert_response :success
  end
end
