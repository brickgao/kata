require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @post = posts(:testpost)
    @user = users(:alice)
    session[:user_id] = @user.id
  end

  test "should create successfully with valid params" do
    post_params = {
      :comment => {
        :body => "test comment",
        :post => @post.id
      }
    }
    post :create, post_params
    assert_response :redirect
  end

  test "should create unsuccessfully with empty body" do
    post_params = {
      :comment => {
        :body => "",
        :post => @post.id
      }
    }
    post :create, post_params
    assert_response :redirect
    assert flash[:danger]
  end

  test "should show comments" do
    get :index
    assert_response :success
    assert_template 'comments/index'
    assert_select 'div.comments'
  end
end
